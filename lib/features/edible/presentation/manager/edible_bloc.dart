import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:edible/features/edible/domain/use_cases/create_initialize_user_use_cae.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/edible_model.dart';
import '../../data/models/user_model.dart';
import '../../domain/use_cases/add_edible_use_case.dart';
import '../../domain/use_cases/get_edibles_data_use_case.dart';
import '../../domain/use_cases/get_user_use_case.dart';

part 'edible_event.dart';
part 'edible_state.dart';

class EdibleBloc extends Bloc<EdibleEvent, EdibleState> {
  final GetEdiblesDataUseCase getEdiblesDataUseCase;
  final GetUserModelUseCase getUserModelUseCase;
  final AddEdibleUseCase addEdibleUseCase;
  final CreateInitializeUserUseCase initializeUser;
  EdibleBloc(
      {this.getEdiblesDataUseCase,
      this.getUserModelUseCase,
      this.addEdibleUseCase,
      this.initializeUser})
      : super(EdibleState(status: EdibleStateStatus.PURE));

  @override
  Stream<EdibleState> mapEventToState(
    EdibleEvent event,
  ) async* {
    if (event is GetEdiblesData) {
      yield state.copyWith(status: EdibleStateStatus.LOADING);
      final failureOrEdibles = await getEdiblesDataUseCase(NoParams());
      yield* _eitherFailureOrEdibles(failureOrEdibles, state);
    }
    if (event is SearchByName) {
      yield state.copyWith(status: EdibleStateStatus.LOADING);
      List show = await _makeList(event.query);
      yield state.copyWith(
          status: EdibleStateStatus.LOADED, showingEdibles: show);
    }
    if (event is GetHomeEdibles) {
      yield state.copyWith(status: EdibleStateStatus.LOADING);
      final failureOrUser = await getUserModelUseCase(NoParams());
      yield* _eitherFailureOrUser(failureOrUser, state);
    }
    if (event is GoToEdiblePageEvent) {
      yield state.copyWith(status: EdibleStateStatus.LOADING);
    }
    if (event is AddEdibleToUserDataBaseEvent) {
      yield state.copyWith(status: EdibleStateStatus.LOADING);
      final failureOrUser = await addEdibleUseCase(Params(
        amount: event.amount,
        date: event.date,
        points: event.points,
        edibleModel: event.edibleModel,
      ));
      yield* _eitherFailureOrUser(failureOrUser, state);
    }
    if (event is CreateInitializeUserEvent) {
      yield state.copyWith(status: EdibleStateStatus.LOADING);
      final failureOrUser = await initializeUser(NoParams());
      yield* _eitherFailureOrUser(failureOrUser, state);
    }
  }

  Future<List> _makeList(String query) async {
    List show = List();
    if (state.edibles == null) return show;
    for (dynamic edible in state.edibles) {
      if (edible.name.contains(query)) {
        show.add(edible);
      }
    }
    return show;
  }

  Stream<EdibleState> _eitherFailureOrEdibles(
      Either<Failure, List<EdibleModel>> failureOrEdibles,
      EdibleState state) async* {
    yield failureOrEdibles.fold(
      (failure) => state.copyWith(
        status: EdibleStateStatus.ERROR,
        message: failure.message,
      ),
      (edibles) => state.copyWith(
        status: EdibleStateStatus.LOADED,
        showingEdibles: edibles,
        edibles: edibles,
      ),
    );
  }

  Stream<EdibleState> _eitherFailureOrUser(
      Either<Failure, UserModel> failureOrUser, EdibleState state) async* {
    yield failureOrUser.fold(
      (failure) => state.copyWith(
        status: EdibleStateStatus.ERROR,
        message: failure.message,
      ),
      (user) => state.copyWith(
        status: EdibleStateStatus.LOADED,
        user: user,
      ),
    );
  }
}
