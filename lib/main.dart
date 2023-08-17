import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:load_firebase_images/helper/constants.dart';
import 'package:load_firebase_images/models/product_entity.dart';

import 'firebase_operations/firebase_options.dart';
import 'firebase_operations/firebase_storage.dart';
import 'helper/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ProductEntity>? products;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('FireBase')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            products == null
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () async {
                      final FireBaseStorageRepository fireStorage =
                          FireBaseStorageRepository(
                        firebaseStorageInstance: FirebaseStorage.instance,
                      );
                      final List<String> imgUrls = await fireStorage
                          .getDirectoryFilesUrls(dirPath: '$childPath images');
                      setState(() {
                        products = Helper.transformUrlsToProductItems(
                          urls: imgUrls,
                          title: prodTitle,
                        );
                      });
                      if (products != null) {
                        for (ProductEntity product in products!) {
                          log('products img url is : ${product.imgUrl}');
                        }
                        Helper.addItemsListToFireBaseDataBase(
                          products: products!,
                          refPath: refPath,
                          childPath: childPath,
                        );
                      }
                    },
                    child: const Text('Add'),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Column(
                        children: [
                          Text(
                            'Image number = ${products!.length}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: products!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ',
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      products![index].imgUrl,
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                height: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        )),
      ),
    );
  }
}
//img Urls is : [https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/bars%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.41.44%20AM.jpeg?alt=media&token=c084092e-55a1-4298-b3f8-0cd2494ae55d, https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/bars%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.41.45%20AM.jpeg?alt=media&token=efad16fb-0157-45d7-a1e0-3b4581d41ea1, https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/bars%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.42.00%20AM%20(2).jpg?alt=media&token=021bde1b-3936-4c96-8fe0-f69adf7eb92f, https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/bars%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.42.01%20AM.jpeg?alt=media&token=0960da64-f7db-4992-89a1-fac8aa24a3a0, https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/bars%20images%2FWhatsApp%20Image%202023-07-25%20at%205.31.53%20AM%20(3).jpeg?alt=media&token=84bb415a-c253-41f1-b2c0-2f1cc9713a67, https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/bars%20images%2FWhatsApp%20Image%202023-07-25%20at%205.32.09%20AM%20(1).jpg?alt=media&token=7cf75c1f-0234-44c5-93a6-212f48858523, https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/bars%20images%2FWhatsApp%20Image%202023-07-25%20at%205.34.40%20AM.jpeg?alt=media&token=61f855f7-c719-4d1e-9fa3-14984f600f48]
