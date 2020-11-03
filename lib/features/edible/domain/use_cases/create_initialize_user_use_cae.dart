import 'package:dartz/dartz.dart';
import 'package:edible/core/error/failure.dart';
import 'package:edible/core/usecases/usecase.dart';
import 'package:edible/features/edible/data/models/edible_model.dart';
import 'package:edible/features/edible/data/models/user_model.dart';
import 'package:edible/features/edible/domain/repositories/edible_repository.dart';

class CreateInitializeUserUseCase implements UseCase<UserModel, NoParams> {
  final EdibleRepository repository;

  CreateInitializeUserUseCase({this.repository});

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.initializeUser();
  }
}
