import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/edible_model.dart';
import '../../data/models/user_model.dart';

abstract class EdibleRepository {
  Future<Either<Failure, List<EdibleModel>>> getEdiblesData();
  Future<Either<Failure, UserModel>> getUserModel();
  Future<Either<Failure, UserModel>> addEdible(
      amount, date, edibleModel, points);
  Future<Either<Failure, UserModel>> initializeUser();
}
