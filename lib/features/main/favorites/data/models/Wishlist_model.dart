class WishlistModel {
  final String status;
  final String message;
  final List<String> data;

  WishlistModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      status: json['status'],
      message: json['message'],
      data: List<String>.from(json['data']),
    );
  }
}
