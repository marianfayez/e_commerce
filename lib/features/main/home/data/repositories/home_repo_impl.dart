import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/features/main/home/data/data_sources/remote/home_remote_ds.dart';
import 'package:e_commerce_app/features/main/home/data/data_sources/remote/home_remote_ds_imp.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:e_commerce_app/features/main/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  HomeRemoteDs homeRemoteDs;

  HomeRepoImpl(this.homeRemoteDs);

  @override
  Future<Either<RouteFailures, CategoriesModel>> getCategories() async{
    try{
     var result=await homeRemoteDs.getCategories();
      return Right(result);
    }catch(e){
      return Left(RemoteFailures(e.toString()));
    }

  }
}
