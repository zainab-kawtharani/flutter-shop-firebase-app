class Shoe {
  final String id;
  final String brand;
  final String image;
  final int price;
  final String description;
  final String name;

  Shoe(
      {required this.id,
      required this.brand,
      required this.image,
      required this.price,
      required this.description,
      required this.name});

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
        brand: json['brand'],
        image: json['images'],
        price: json['price'],
        description: json['description'],
        name: json['Name'],
        id: json['id']);
  }
}
