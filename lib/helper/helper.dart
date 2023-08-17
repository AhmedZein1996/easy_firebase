import 'package:firebase_database/firebase_database.dart';
import 'package:load_firebase_images/models/product_entity.dart';

import '../firebase_operations/fiebase_real_time_database.dart';

class Helper {
  static List<ProductEntity> transformUrlsToProductItems(
      {required List<String> urls, required String title}) {
    List<ProductEntity> productItems = urls
        .map(
          (url) => ProductEntity(
            title: title,
            imgUrl: url,
            price: '',
            weight: '',
            description: '',
          ),
        )
        .toList();
    return productItems;
  }

  static addItemsListToFireBaseDataBase({
    required List<ProductEntity> products,
    required String refPath,
    required String childPath,
  }) async {
    FireBaseRealTimeDataBseRepository realTimeDataBase =
        FireBaseRealTimeDataBseRepository(
            firebaseDatabaseInstance: FirebaseDatabase.instance);
    for (ProductEntity product in products) {
      await realTimeDataBase.createNewItem(
          productEntity: product, refPath: refPath, childPath: childPath);
    }
  }
}
