part of 'edible_bloc.dart';

abstract class EdibleEvent {}

class GetEdiblesData extends EdibleEvent {}

class SearchByName extends EdibleEvent {
  final query;

  SearchByName(this.query);
}

class GetHomeEdibles extends EdibleEvent {}

class GoToEdiblePageEvent extends EdibleEvent {}

class AddEdibleToUserDataBaseEvent extends EdibleEvent {
  final amount;
  final date;
  final edibleModel;
  final points;

  AddEdibleToUserDataBaseEvent(
      {this.amount, this.date, this.edibleModel, this.points});
}

class CreateInitializeUserEvent extends EdibleEvent {}
