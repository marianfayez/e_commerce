import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';

abstract class HomeRemoteDs {

  Future<CategoriesModel>getCategories();

}