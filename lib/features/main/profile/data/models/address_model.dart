class AddressModel {
  AddressModel({
      this.status, 
      this.message,
    this.results,

    this.data,});

  AddressModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    results = json['results'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AddressData.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<AddressData>? data;
  int? results;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['results'] = results;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AddressData {
  AddressData({
      this.id, 
      this.name, 
      this.details, 
      this.phone, 
      this.city,});

  AddressData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    details = json['details'];
    phone = json['phone'];
    city = json['city'];
  }
  String? id;
  String? name;
  String? details;
  String? phone;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['details'] = details;
    map['phone'] = phone;
    map['city'] = city;
    return map;
  }

}