import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorageRepository {
  final FirebaseStorage firebaseStorageInstance;

  FireBaseStorageRepository({
    required this.firebaseStorageInstance,
  });

  Future<List<String>> getDirectoryFilesUrls({required String dirPath}) async {
    try {
      log('*************************');
      log('start to get all data urls in firebase storage...');
      log('*************************');
      final List<String> urls = [];
      final ListResult result =
          await firebaseStorageInstance.ref().child(dirPath).list();
      final List<Reference> allFiles = result.items;
      log('items is : $allFiles');
      await Future.forEach<Reference>(allFiles, (file) async {
        final String fileUrl = await file.getDownloadURL();
        urls.add(fileUrl);
      });
      log('*************************');
      log('get all data urls in firebase storage finished...');
      log('*************************');
      return urls;
    } catch (e) {
      log('exception is : $e');
      return [];
    }
  }

  Future<void> createNewFile({required File file, required String path}) async {
    log('*************************');
    log('start to create new file in Firebase storage...');
    log('*************************');
    final storageRef = firebaseStorageInstance.ref();
    final imageRef = storageRef.child(path);
    await imageRef.putFile(file);
    log('*************************');
    log('create new file in Firebase storage finished...');
    log('*************************');
  }
}
