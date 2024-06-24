class ProductModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final int price;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.price
  });

  factory ProductModel.fromSnapshot(doc) {
    return ProductModel(
      id: doc['id'],
      name: doc['name'],
      description: doc['description'],
      imageUrl: doc['imageUrl'],
      category: doc['category'],
      price: doc['price']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'price': price
    };
  }
}