class Item {
  String id;
  String name;
  int quantity;
  double price;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}