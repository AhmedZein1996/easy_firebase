class ProductEntity {
  final String title;
  final String imgUrl;
  final String price;
  final String weight;
  final String description;

  const ProductEntity({
    required this.title,
    required this.imgUrl,
    required this.price,
    required this.weight,
    required this.description,
  });
  Map<String, dynamic> toJson() {
    return {
      'imgUrl': imgUrl,
      'title': title,
      'description': description,
      'price': price,
      'weight': weight,
    };
  }
}

final products = [
  const ProductEntity(
    title: 'سبيكة',
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/jewellery%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.41.44%20AM.jpeg?alt=media&token=8c4b8480-131c-4686-8f15-7a368fd33e6b',
    price: '',
    weight: '',
    description: '',
  ),
  const ProductEntity(
    title: 'سبيكة',
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/jewellery%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.41.45%20AM.jpeg?alt=media&token=561f0762-e35a-458e-9cf9-7f7b1e2a60af',
    price: '',
    weight: '',
    description: '',
  ),
  const ProductEntity(
    title: 'سبيكة',
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/jewellery%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.42.00%20AM%20(2).jpg?alt=media&token=ef2f48ac-6038-4eff-a296-5d4e315024f3',
    price: '',
    weight: '',
    description: '',
  ),
  const ProductEntity(
    title: 'سبيكة',
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/jewellery%20images%2FWhatsApp%20Image%202023-07-20%20at%2012.42.01%20AM.jpeg?alt=media&token=41d020c5-fbd5-404e-a1c1-d2aba2776a9c',
    price: '',
    weight: '',
    description: '',
  ),
  const ProductEntity(
    title: 'سبيكة',
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/jewellery%20images%2FWhatsApp%20Image%202023-07-25%20at%205.31.53%20AM%20(3).jpeg?alt=media&token=45c2207d-cf10-4a01-bdd7-73e6bf86e4ad',
    price: '',
    weight: '',
    description: '',
  ),
  const ProductEntity(
    title: 'سبيكة',
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/jewellery%20images%2FWhatsApp%20Image%202023-07-25%20at%205.32.09%20AM%20(1).jpg?alt=media&token=7d6703a0-5371-4ae6-906d-df57aea4b0e6',
    price: '',
    weight: '',
    description: '',
  ),
  const ProductEntity(
    title: 'سبيكة',
    imgUrl:
        'https://firebasestorage.googleapis.com/v0/b/taher-jewellery.appspot.com/o/jewellery%20images%2FWhatsApp%20Image%202023-07-25%20at%205.34.40%20AM.jpeg?alt=media&token=a9d3dfd0-5d31-43be-a55c-e6c8bbe351a2',
    price: '',
    weight: '',
    description: '',
  ),
];
