import 'dart:convert';

class FoodModel {
  final String nameFood;
  final String price;
  final String detail;
  final String image;
  FoodModel({
    this.nameFood,
    this.price,
    this.detail,
    this.image,
  });

  FoodModel copyWith({
    String nameFood,
    String price,
    String detail,
    String image,
  }) {
    return FoodModel(
      nameFood: nameFood ?? this.nameFood,
      price: price ?? this.price,
      detail: detail ?? this.detail,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameFood': nameFood,
      'price': price,
      'detail': detail,
      'image': image,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      nameFood: map['nameFood'],
      price: map['price'],
      detail: map['detail'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodModel(nameFood: $nameFood, price: $price, detail: $detail, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FoodModel &&
      other.nameFood == nameFood &&
      other.price == price &&
      other.detail == detail &&
      other.image == image;
  }

  @override
  int get hashCode {
    return nameFood.hashCode ^
      price.hashCode ^
      detail.hashCode ^
      image.hashCode;
  }
}
