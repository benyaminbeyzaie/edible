import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/edible_model.dart';
import '../repositories/edible_repository.dart';

class GetEdiblesDataUseCase implements UseCase<List<EdibleModel>, NoParams> {
  final EdibleRepository repository;

  GetEdiblesDataUseCase({this.repository});

  @override
  Future<Either<Failure, List<EdibleModel>>> call(NoParams params) async {
    return await repository.getEdiblesData();
  }
}
