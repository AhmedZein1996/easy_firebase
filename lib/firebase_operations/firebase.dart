import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// void main() async {
//   print('************************** all files *************************');
//   await fetchFiles();
// }

// final List bars = [];
//
// uploadFiles() {
//   bars.map(
//     (bar) => uploadFile(
//       image: bar.imge,
//       price: bar.price,
//       title: bar.title,
//       description: bar.description,
//     ),
//   );
// }
//
// Future<void> uploadFile({
//   required File image,
//   required String description,
//   required String title,
//   required String price,
// }) async {
//   Reference storageReference =
//       FirebaseStorage.instance.ref().child('jewellery images/${image.path}');
//   UploadTask uploadTask = storageReference.putFile(image);
//   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
//     () {},
//   );
//   final imageUrl = await taskSnapshot.ref.getDownloadURL();
//   addProductToFireStore(
//     imgUrl: imageUrl,
//     price: price,
//     title: title,
//     description: description,
//   );
// }

const dirPath = 'C:\\Users\\Ahmed\\Desktop\\jewellery\\bars';

fetchFiles() async {
  List<File> files = await getAllFiles(dirPath);
  log('length = ${files.length}');
  log('path of first image = ${files.first.path}');
  uploadImages(files);
}

Future<List<File>> getAllFiles(String path) async {
  final List<FileSystemEntity> entities = await Directory(path).list().toList();
  return entities.whereType<File>().toList();
}

//**********************************************************************//
Future<List<String>> uploadImages(List<File> images) async {
  log('*************************');
  log('Upload images starting...');
  log('*************************');
  List<String> imageUrls = await Future.wait(
    images.map(
      (image) async => await uploadImage(
        image,
      ),
    ),
  );
  for (String imgUrl in imageUrls) {
    log(imgUrl);
  }
  log('*************************');
  log('Upload images finished...');
  log('*************************');

  log('*************************');
  log('add Products To FireStore starting...');
  log('*************************');
  // Future.wait(
  //   imageUrls.map(
  //     (imageUrl) async => await addNewItemToFireStoreDocument(
  //       imgUrl: imageUrl,
  //       title: 'سبيكة',
  //       price: '',
  //       description: '',
  //     ),
  //   ),
  // );
  log('*************************');
  log('add Products To FireStore finished...');
  log('*************************');

  return imageUrls;
}

Future<String> uploadImage(File image) async {
  log('*************************');
  log('Upload image (${image.path}) starting...');
  log('*************************');
// Create the file metadata
  final metadata = SettableMetadata(contentType: "image/jpeg");

// Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
  UploadTask uploadTask =
      storageRef.child("images/${image.path}").putFile(image, metadata);

// Listen for state changes, errors, and completion of the upload.
  String url = '';
  uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
    switch (taskSnapshot.state) {
      case TaskState.running:
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        log("Upload is $progress% complete.");
        break;
      case TaskState.paused:
        log("Upload is paused.");
        break;
      case TaskState.canceled:
        log("Upload was canceled");
        break;
      case TaskState.error:
        log("Upload was on error");
        // Handle unsuccessful uploads
        break;
      case TaskState.success:
        log("Upload is success");
        url = await storageRef.getDownloadURL();
        log("imgUrl is $url");
        // Handle successful uploads on complete
        // ...
        break;
    }
  });
  // String url;
  // var bytes = await image.readAsBytes();
  // try {
  //   Reference reference = FirebaseStorage.instance.ref('images');
  //   UploadTask uploadTaskSnapshot = await reference
  //       .put(bytes, fb.UploadMetadata(contentType: 'image/png'))
  //       .future;
  //   var imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
  //   url = imageUri.toString();
  // } catch (e) {
  //   print(e);
  // }
  // Reference storageReference =
  //     FirebaseStorage.instance.ref().child('jewellery images/${image.path}');
  // UploadTask uploadTask = storageReference.putFile(image);
  // await uploadTask.whenComplete(
  //   () {},
  // );
  log('*************************');
  log('Upload image (${image.path}) finished...');
  log('*************************');
  return url;
}

//**********************************************************************//

// Future<List<FileSystemEntity>> dirContents(Directory dir) {
//   var files = <FileSystemEntity>[];
//   var completer = Completer<List<FileSystemEntity>>();
//   var lister = dir.list(recursive: false);
//   lister.listen((file) => files.add(file),
//       // should also register onError
//       onDone: () => completer.complete(files));
//   return completer.future;
// }
Future<void> readImagesFromAssets() async {
  log('************************** start loading assets *************************');
  final manifestContent = await rootBundle.loadString('AssetManifest.json');

  final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  // >> To get paths you need these 2 lines

  // final keys = manifestMap.forEach((key, value) {
  //   log('keys $key');
  // });
  final imagePaths = manifestMap.keys
      .where((String key) => key.contains('images/'))
      .where((String key) => key.contains('WhatsApp'))
      .toList();
  // final imagePaths = manifestMap.keys
  //     .where((String key) => key.contains('images/'))
  //     .where((String key) => key.contains('.jpeg'))
  //     .toList();
  log('length = $imagePaths');
}

Future<File> convertImageAssetToImageFile() async {
  log("start load Images From assets.");
  final byteData = await rootBundle.load('assets/images/bar.jpeg');
  log("byteData is = ${byteData.toString()}.");
  final file = File('${(await getTemporaryDirectory()).path}/bar.jpeg');
  log("file is = ${file.path}.");
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  final String fileName = basename(file.path);
  final String title = fileName; // You can adjust the title as needed
  final String filePath = file.path;

  final Map<String, dynamic> image = {};
  image.addAll({"title": title, "filePath": filePath});
  await uploadImage(file);
  return file;
}
