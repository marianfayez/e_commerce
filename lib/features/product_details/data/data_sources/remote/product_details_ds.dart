import 'package:e_commerce_app/features/product_details/data/model/product_details_model.dart';

abstract class ProductDetailsDs{

  Future<ProductDetailsModel> getProductDetails(String productId);

}