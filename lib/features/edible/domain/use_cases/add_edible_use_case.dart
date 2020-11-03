import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../repositories/edible_repository.dart';

class AddEdibleUseCase implements UseCase<UserModel, Params> {
  final EdibleRepository repository;

  AddEdibleUseCase({this.repository});

  @override
  Future<Either<Failure, UserModel>> call(Params params) async {
    return await repository.addEdible(
        params.amount, params.date, params.edibleModel, params.points);
  }
}

class Params {
  final amount;
  final date;
  final edibleModel;
  final points;

  Params({this.amount, this.date, this.edibleModel, this.points});
}
