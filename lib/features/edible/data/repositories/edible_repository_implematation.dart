import 'package:dartz/dartz.dart';
import 'package:edible/core/time/date.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/custom_exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/edible_repository.dart';
import '../data_sources/edible_local_data_source.dart';
import '../data_sources/edible_remote_data_source.dart';
import '../models/edible_model.dart';
import '../models/user_model.dart';

class EdibleRepositoryImplementation implements EdibleRepository {
  final EdibleLocalDataSource localDataSource;
  final EdibleRemoteDataSource remoteDataSource;

  EdibleRepositoryImplementation({this.localDataSource, this.remoteDataSource});

  @override
  Future<Either<Failure, List<EdibleModel>>> getEdiblesData() async {
    try {
      var edibles;
      if (await localDataSource.hasUserDownloadedTheData()) {
        edibles = await localDataSource.getEdibles();
      } else {
        print('downloading the data');
        edibles = await remoteDataSource.getEdibles();
        await localDataSource.saveEdibles(edibles);
        await localDataSource.setUserDownloadedTheData();
      }
      return Right(edibles);
    } on CustomException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserModel() async {
    try {
      final UserModel model = await localDataSource.getUserModel();
      return Right(model);
    } on CustomException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> addEdible(
      amount, date, edibleModel, point) async {
    try {
      UserModel newModel =
          await localDataSource.addEdible(amount, date, edibleModel, point);
      return (Right(newModel));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> initializeUser() async {
    try {
      UserModel model = await localDataSource.initializeUser();
      return Right(model);
    } on CustomException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
