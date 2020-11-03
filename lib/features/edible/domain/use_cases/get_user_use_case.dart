import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../repositories/edible_repository.dart';

class GetUserModelUseCase implements UseCase<UserModel, NoParams> {
  final EdibleRepository repository;

  GetUserModelUseCase({this.repository});

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUserModel();
  }
}
