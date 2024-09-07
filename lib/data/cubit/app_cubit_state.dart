import 'package:aquacall/data/models/app_model.dart';

abstract class AppState {}

class DataInitial extends AppState {}

class DataLoading extends AppState {}

class DataLoaded extends AppState {
  final List<AppModel> data;

  DataLoaded(this.data);
}

class DataUpdated extends AppState {
  final int newData;

  DataUpdated(this.newData);
}

class DataError extends AppState {
  final String message;

  DataError(this.message);
}
