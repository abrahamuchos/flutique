import 'package:flutique/feature/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.brand,
    required super.sku,
    super.tags,
    super.dimensions,
    super.images,
    super.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      price: (map['price'] as num).toDouble(), //Protección si la API devuelve un numero entero
      discountPercentage: (map['discountPercentage'] as num).toDouble(),
      rating: map['rating'],
      stock: map['stock'],
      brand: map['brand'],
      sku: map['sku'],
      tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
      dimensions:
          map['dimensions'] != null
              ? (map['dimensions'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(key, (value as num).toDouble()),
              )
              : null,
      images: map['images'] != null ? List<String>.from(map['images']) : null,
      thumbnail: map['thumbnail'],
    );
  }
}
