class Product {
  late int id;
  late String name;
  late int code;
  late double unitPrice;
  late int unitInStock;
  late String photo;
  late int userId;
  late int qauntity = 0;
  Product();
  Product.newInstance({
    required this.id,
    required this.name,
    required this.code,
    required this.unitPrice,
    required this.unitInStock,
    required this.photo,
    required this.userId,
  });

  double amount() {
    int qty = 2;
    return qty * this.unitPrice;
  }
  factory Product.fromJson(Map<Object, dynamic> json) {
    return Product.newInstance(
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
