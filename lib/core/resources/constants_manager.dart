import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppConstants {
  static const String delete = "Delete";
  static const String searchHint = "what do you search for?";
  static const String addToCart = "Add to Cart";
  static const String baseUrl = "https://ecommerce.routemisr.com";

  static void loadingDialog(BuildContext context, bool isLoading) {
    try {
      if (isLoading) {
        context.loaderOverlay.show();
      } else {
        if (context.loaderOverlay.visible) {
          context.loaderOverlay.hide();
        }
      }
    } catch (e) {
      debugPrint('Loader overlay error: $e');
    }
  }

}
