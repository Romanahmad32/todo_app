import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/use_cases/load_todo_collections.dart';

import '../../../../core/use_cases/use_case.dart';
import '../../../../domain/entities/todo_collection.dart';

part 'todo_overview_cubit_state.dart';

class ToDoOverviewCubit extends Cubit<ToDoOverviewCubitState> {
  final LoadToDoCollections loadToDoCollections;

  ToDoOverviewCubit({required this.loadToDoCollections})
      : super(ToDoOverviewCubitLoadingState());

  Future<void> readToDoCollections() async {
    try {
      final collectionsFuture = loadToDoCollections(NoParams());
      final collections = await collectionsFuture;
      collections.fold(
          (failure) => emit(ToDoOverviewCubitErrorState()),
          (collections) =>
              emit(ToDoOverviewCubitLoadedState(collections: collections)));
    } on Exception catch (e) {
      emit(ToDoOverviewCubitErrorState());
    }
  }
}
