class EndPoints {
  static const String signUp = "/api/v1/auth/signup";
  static const String login = "/api/v1/auth/signin";
  static const String categories = "/api/v1/categories";
  static const String products = "/api/v1/products";
  static const String cart = "/api/v1/cart";
  static const String addToFavorite = "/api/v1/wishlist";
  static const String addAddress = "/api/v1/addresses";
  static const String updateProfile = "/api/v1/users/updateMe/";
  static const String changeMyPassword = "/api/v1/users/changeMyPassword";

  static String subCategories(String id) =>
      "/api/v1/categories/$id/subcategories";

  static String deleteAddress(String? id) =>
      "/api/v1/addresses/$id";
  static String deleteCartItem(String? id) =>
      "/api/v1/cart/$id";
  static String updateCartItem(String? id) =>
      "/api/v1/cart/$id";
  static String productDetails(String id) =>
      "/api/v1/products/$id";
  static String removeFromFavorite(String? id) =>
      "/api/v1/wishlist/$id";
}
