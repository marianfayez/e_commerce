import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/features/main/categories/data/data_sources/remote/categories_remote_ds.dart';
import 'package:e_commerce_app/features/main/categories/domain/repositories/categories_repo.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:CategoriesRepo )
class CategoriesRepoImpl implements CategoriesRepo{

  CategoriesRemoteDs categoriesRemoteDs;
  CategoriesRepoImpl(this.categoriesRemoteDs);

  @override
  Future<Either<RouteFailures, CategoriesModel>> getSubCategories(String catId) async{
    try{
      var result=await categoriesRemoteDs.getSubCategories(catId);
      return Right(result);
    }catch(e){
      return Left(RemoteFailures(e.toString()));
    }

  }


}