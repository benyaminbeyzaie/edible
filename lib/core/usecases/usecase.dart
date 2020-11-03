import 'package:dartz/dartz.dart';

import '../error/failure.dart';

///  A use case is class that is used for sending request from repository to the
///  data sources.
abstract class UseCase<Type, Params> {
  // call method is called automatically when class is called.
  Future<Either<Failure, Type>> call(Params params);
}

// if that use case does'nt have any parameter I use this class.
class NoParams {}
