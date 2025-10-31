import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable{
  CategoriesModel({
      this.results, 
      this.metadata, 
      this.data,});

  CategoriesModel.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryData .fromJson(v));
      });
    }
  }
  int? results;
  Metadata? metadata;
  List<CategoryData >? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  List<Object?> get props => [results,metadata,data];

}

class CategoryData  extends Equatable{
  CategoryData ({
      this.id, 
      this.name, 
      this.slug, 
      this.image, 
      this.createdAt, 
      this.updatedAt,});

  CategoryData .fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  @override
  List<Object?> get props => [id,name,slug,image,createdAt,updatedAt];

}

