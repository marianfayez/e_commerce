import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';

abstract class CategoriesRemoteDs{

  Future<CategoriesModel> getSubCategories(String id);

}