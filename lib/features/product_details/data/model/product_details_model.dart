class ProductDetailsModel {
  Data? data;

  ProductDetailsModel({this.data});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
  };
}

class Data {
  int? sold;
  List<String>? images;
  List<Subcategory>? subcategory;
  int? ratingsQuantity;
  String? sId;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? price;
  String? imageCover;
  Category? category;
  dynamic brand;
  double? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<dynamic>? reviews;
  String? id;

  Data({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.sId,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.reviews,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sold: json['sold'],
      images: List<String>.from(json['images'] ?? []),
      subcategory: (json['subcategory'] as List<dynamic>?)
          ?.map((e) => Subcategory.fromJson(e))
          .toList(),
      ratingsQuantity: json['ratingsQuantity'],
      sId: json['_id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
      imageCover: json['imageCover'],
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      brand: json['brand'],
      ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
      reviews: json['reviews'] as List<dynamic>?,
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'sold': sold,
    'images': images,
    'subcategory': subcategory?.map((e) => e.toJson()).toList(),
    'ratingsQuantity': ratingsQuantity,
    '_id': sId,
    'title': title,
    'slug': slug,
    'description': description,
    'quantity': quantity,
    'price': price,
    'imageCover': imageCover,
    'category': category?.toJson(),
    'brand': brand,
    'ratingsAverage': ratingsAverage,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
    'reviews': reviews,
    'id': id,
  };
}

class Subcategory {
  String? sId;
  String? name;
  String? slug;
  String? category;

  Subcategory({this.sId, this.name, this.slug, this.category});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      sId: json['_id'],
      name: json['name'],
      slug: json['slug'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'name': name,
    'slug': slug,
    'category': category,
  };
}

class Category {
  String? sId;
  String? name;
  String? slug;
  String? image;

  Category({this.sId, this.name, this.slug, this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      sId: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'name': name,
    'slug': slug,
    'image': image,
  };
}
