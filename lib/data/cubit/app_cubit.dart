import 'package:aquacall/data/cubit/app_cubit_state.dart';
import 'package:aquacall/data/models/app_model.dart';
import 'package:aquacall/data/services/database_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(DataInitial());

  final DatabaseService _databaseService = DatabaseService.instance;

  void fetchData() async {
    try {
      emit(DataLoading());
      final data = await _databaseService.getData();
      emit(DataLoaded(data));
    } catch (e) {
      emit(DataError('Failed to fetch data $e'));
      print(e);
    }
  }

  void addData(int age, double height, double weight) async {
    try {
      await _databaseService.insertUser(age, height, weight);
      fetchData();
    } catch (e) {
      emit(DataError('Failed to add data $e'));
      print(e);
    }
  }

  void updateAmount(AppModel appModel, int amount) async {
    try {
      await _databaseService.updateAmount(appModel, amount);
      fetchData();
    } catch (e) {
      emit(DataError('Failed to update amount $e'));
      print(e);
    }
  }

  void deleteAmount(AppModel appModel) async {
    try {
      await _databaseService.deleteAmount(appModel);
      fetchData();
    } catch (e) {
      emit(DataError('Failed to delete amount $e'));
      print(e);
    }
  }

  void updateUserData(
      AppModel appModel, int age, double height, double weight) async {
    try {
      emit(DataLoading());
      final data =
          await _databaseService.updateUser(appModel, age, height, weight);
      fetchData();
      emit(DataLoaded(data));
    } catch (e) {
      emit(DataError('Failed to update user data $e'));
      print(e);
    }
  }
}
