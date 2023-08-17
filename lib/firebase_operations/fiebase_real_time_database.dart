import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:load_firebase_images/models/product_entity.dart';

class FireBaseRealTimeDataBseRepository {
  final FirebaseDatabase firebaseDatabaseInstance;

  FireBaseRealTimeDataBseRepository({
    required this.firebaseDatabaseInstance,
  });

  Future<void> createNewItem(
      {required ProductEntity productEntity,
      required String refPath,
      required String childPath}) async {
    log('*************************');
    log('start to create new item in real time database...');
    log('*************************');
    final DatabaseReference databaseReference =
        firebaseDatabaseInstance.ref(refPath).child(childPath);
    DatabaseReference newRef = databaseReference.push();
    newRef.set(
      productEntity.toJson(),
    );
    log('*************************');
    log('create new item in real time database finished...');
    log('*************************');
  }

  Future<void> getAllData() async {
    log('*************************');
    log('start to get all data in real time database....');
    log('*************************');
    final DatabaseReference databaseReference = firebaseDatabaseInstance.ref();
    databaseReference.once().then(
          (DatabaseEvent event) => log(
            'Data : ${event.snapshot.value}',
          ),
        );
    log('*************************');
    log('get all data in real time database finished...');
    log('*************************');
  }
}
