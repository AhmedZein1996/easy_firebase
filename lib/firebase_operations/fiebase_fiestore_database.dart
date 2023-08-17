import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:load_firebase_images/models/product_entity.dart';

class FireBaseFireStoreRepository {
  FirebaseFirestore fireStoreInstance;

  FireBaseFireStoreRepository({
    required this.fireStoreInstance,
  });

  Future<void> createNewDocument({
    required ProductEntity productEntity,
    required int count,
    required String collection,
    required String document,
  }) async {
    log('*************************');
    log('start to create new document in FireStore ...');
    log('*************************');

    final collectionRef = fireStoreInstance.collection(collection);
    var documentSnapshot = await collectionRef.doc('$document$count').get();
    final newItem = {
      'imgUrl': productEntity.imgUrl,
      'title': productEntity.title,
      'description': productEntity.description,
      'price': productEntity.price,
      'weight': productEntity.weight,
    };
    if (!documentSnapshot.exists) {
      await collectionRef.doc('$document$count').set(newItem);
    }
    log('*************************');
    log('create new document in FireStore finished...');
    log('*************************');
  }

  Future<List> getAllCollectionDocuments({required String collection}) async {
    log('*************************');
    log('start to get all data in firebase firestore...');
    log('*************************');
    final collectionRef = fireStoreInstance.collection(collection);
    QuerySnapshot querySnapshot = await collectionRef.get();
    log('*************************');
    log('get all data in firebase firestore finished...');
    log('*************************');
    // Get data from docs and convert map to List
    return querySnapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }

// Future<void> getAllCollections({
//   required ProductEntity productEntity,
//   required int count,
//   required String collection,
//   required String doc,
// }) async {
//   log('*************************');
//   log('start to get all data in firebase firestore...');
//   log('*************************');
//   final userCollection = fireStore.collection(collection);
//   var documentSnapshot = await userCollection.doc('$doc$count').get();
//   final newItem = {
//     'imgUrl': productEntity.imgUrl,
//     'title': productEntity.title,
//     'description': productEntity.description,
//     'price': productEntity.price,
//     'weight': productEntity.weight,
//   };
//   if (!documentSnapshot.exists) {
//     await userCollection.doc('$doc$count').set(newItem);
//   }
//   log('*************************');
//   log('get all data in firebase firestore finished...');
//   log('*************************');
// }
}
