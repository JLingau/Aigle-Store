class ProductCart {
  final int id;
  final String name;
  final String description;
  final String image;
  final String customization;
  final int price;
  int quantity;

  ProductCart({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.customization,
    required this.price,
    required this.quantity
  });

  factory ProductCart.fromSnapshot(doc) {
    return ProductCart(
      id: doc['id'],
      name: doc['name'],
      description: doc['description'],
      image: doc['image'],
      customization: doc['customization'],
      price: doc['price'],
      quantity: doc['quantity']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'customization': customization,
      'price': price,
      'quantity': quantity
    };
  }
}