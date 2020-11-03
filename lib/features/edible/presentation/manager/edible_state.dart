part of 'edible_bloc.dart';

class EdibleState extends Equatable {
  final status;
  final isDataDownloaded;
  final message;
  final edibles;
  final showingEdibles;
  final user;

  EdibleState(
      {this.status,
      this.isDataDownloaded,
      this.message,
      this.edibles,
      this.showingEdibles,
      this.user});

  EdibleState copyWith({
    status,
    isDataDownloaded,
    message,
    edibles,
    showingEdibles,
    user,
  }) {
    return EdibleState(
      status: status ?? this.status,
      isDataDownloaded: isDataDownloaded ?? this.isDataDownloaded,
      message: message ?? this.message,
      edibles: edibles ?? this.edibles,
      showingEdibles: showingEdibles ?? this.showingEdibles,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props =>
      [status, isDataDownloaded, message, edibles, showingEdibles, user];
}

enum EdibleStateStatus {
  PURE,
  LOADED,
  LOADING,
  ERROR,
}
