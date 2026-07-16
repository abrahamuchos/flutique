import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String>? tags;
  final String? brand;
  final Map<String, double>? dimensions;
  final String sku;
  final List<String>? images;
  final String? thumbnail;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.sku,
    this.tags,
    this.dimensions,
    this.images,
    this.thumbnail,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    tags,
    brand,
    dimensions,
    sku,
    images,
    thumbnail,
  ];
}
