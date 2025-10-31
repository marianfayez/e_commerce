import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:equatable/equatable.dart';

class ProductModel {
  ProductModel({
      this.results, 
      this.metadata, 
      this.data,});

  ProductModel.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Product .fromJson(v));
      });
    }
  }
  int? results;
  Metadata? metadata;
  List<Product >? data;


}

class Product  {
  Product ({
      this.sold, 
      this.images, 
      this.subcategory, 
      this.ratingsQuantity, 
      this.id, 
      this.title, 
      this.slug, 
      this.description, 
      this.quantity, 
      this.price, 
      this.priceAfterDiscount, 
      this.imageCover, 
      this.category, 
      this.brand, 
      this.ratingsAverage, 
      this.createdAt, 
      this.updatedAt, 
      });

  Product .fromJson(dynamic json) {
    sold = (json['sold'] as num?)?.toInt() ?? 0;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['subcategory'] != null) {
      subcategory = [];
      json['subcategory'].forEach((v) {
        subcategory?.add(Subcategory.fromJson(v));
      });
    }
    ratingsQuantity = (json['ratingsQuantity'] as num?)?.toInt() ?? 0;
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = (json['quantity'] as num?)?.toInt() ?? 0;
    price = (json['price'] as num?)?.toDouble() ?? 0.0;
    priceAfterDiscount = (json['priceAfterDiscount'] as num?)?.toDouble() ?? 0.0;
    imageCover = json['imageCover'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    brand = json['brand'];
    ratingsAverage = (json['ratingsAverage'] as num?)?.toDouble() ?? 0.0;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  int? sold;
  List<String>? images;
  List<Subcategory>? subcategory;
  int? ratingsQuantity;
  String? id;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  double? price;
  double? priceAfterDiscount;
  String? imageCover;
  Category? category;
  dynamic brand;
  double? ratingsAverage;
  String? createdAt;
  String? updatedAt;

}

class Metadata extends Equatable{
  Metadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,});

  Metadata.fromJson(dynamic json) {
    currentPage = (json['currentPage'] as num?)?.toInt() ?? 0;
    numberOfPages = (json['numberOfPages'] as num?)?.toInt() ?? 0;
    limit = (json['limit'] as num?)?.toInt() ?? 0;
  }
  int? currentPage;
  int? numberOfPages;
  int? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['numberOfPages'] = numberOfPages;
    map['limit'] = limit;
    return map;
  }

  @override
  List<Object?> get props => [currentPage,numberOfPages,limit];

}

class Category {
  String? id;
  String? name;
  String? slug;
  String? image;

  Category({this.id, this.name, this.slug, this.image});

  Category.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'slug': slug,
    'image': image,
  };
}

class Subcategory {
  String? id;
  String? name;
  String? slug;
  String? category;

  Subcategory({this.id, this.name, this.slug, this.category});

  Subcategory.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'slug': slug,
    'category': category,
  };
}

class FavoriteProductModel {
  final String status;
  final int count;
  final List<Product> data;

  FavoriteProductModel({
    required this.status,
    required this.count,
    required this.data,
  });


  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
      status: json['status'],
      count: json['count'] ?? 0,
      data: json['data'] == null
          ? []
          : List<Product>.from(
          (json['data'] as List).map((e) => Product.fromJson(e))),    );
  }
}

class DeleteFavoriteResponse {
  final String status;
  final String message;
  final List<String> data; // List of deleted product IDs

  DeleteFavoriteResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFavoriteResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<String>.from(json['data'])
          : [],
    );
  }
}