class CartModel {
  String? status;
  int? numOfCartItems;
  String? cartId;
  CartData? data;
  String? message; // <-- add this

  CartModel(
      {this.status, this.numOfCartItems, this.cartId, this.data, this.message});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    message = json['message'];
    data = json['data'] != null ? new CartData .fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['numOfCartItems'] = this.numOfCartItems;
    data['cartId'] = this.cartId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CartData  {
  String? sId;
  String? cartOwner;
  List<CartProduct >? products;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? totalCartPrice;

  CartData (
      {this.sId,
      this.cartOwner,
      this.products,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.totalCartPrice});

  CartData .fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = <CartProduct >[];
      json['products'].forEach((v) {
        products!.add(new CartProduct .fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cartOwner'] = this.cartOwner;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['totalCartPrice'] = this.totalCartPrice;
    return data;
  }
}

class CartProduct  {
  int? count;
  String? sId;
  Product? product;
  int? price;

  CartProduct ({this.count, this.sId, this.product, this.price});

  CartProduct .fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sId = json['_id'];
    if (json['product'] is Map<String, dynamic>) {
      product = Product.fromJson(json['product']);
    } else if (json['product'] is String) {
      product = Product(sId: json['product']); // Just store the ID if it's a String
    }
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['price'] = this.price;
    return data;
  }
}

class Product {
  List<Subcategory>? subcategory;
  String? sId;
  String? title;
  int? quantity;
  String? imageCover;
  Category? category;
  Category? brand;
  num? ratingsAverage;
  String? id;

  Product(
      {this.subcategory,
      this.sId,
      this.title,
      this.quantity,
      this.imageCover,
      this.category,
      this.brand,
      this.ratingsAverage,
      this.id});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new Subcategory.fromJson(v));
      });
    }
    sId = json['_id'];
    title = json['title'];
    quantity = json['quantity'];
    imageCover = json['imageCover'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? new Category.fromJson(json['brand']) : null;
    ratingsAverage = json['ratingsAverage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['imageCover'] = this.imageCover;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['ratingsAverage'] = this.ratingsAverage;
    data['id'] = this.id;
    return data;
  }
}

class Subcategory {
  String? sId;
  String? name;
  String? slug;
  String? category;

  Subcategory({this.sId, this.name, this.slug, this.category});

  Subcategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['category'] = this.category;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? slug;
  String? image;

  Category({this.sId, this.name, this.slug, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    return data;
  }
}
