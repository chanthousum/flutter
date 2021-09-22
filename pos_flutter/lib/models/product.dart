class Product {
  final int id;
  final String name;
  final int code;
  final double unitPrice;
  final int unitInStock;
  final String photo;
  final int userId;


  Product(
      {required this.id,
        required this.name,
        required this.code,
        required this.unitPrice,
        required this.unitInStock,
        required this.photo,
        required this.userId,
        });

  factory Product.fromJson(Map<Object, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      unitPrice: json['unitPrice'],
      unitInStock: json['unitInStock'],
      photo: json['photo'],
      userId: json['userId'],

    );
  }

  Map<Object, dynamic> toJson() {
    final Map<Object, dynamic> data = <Object, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['unitPrice'] = unitPrice;
    data['unitInStock'] = unitInStock;
    data['photo'] = photo;
    data['userId'] = userId;

    return data;
  }
}
