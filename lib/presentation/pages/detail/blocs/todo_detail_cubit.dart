import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry_ids_for_collection.dart';

part 'todo_detail_cubit_state.dart';

class ToDoDetailCubit extends Cubit<ToDoDetailCubitState> {
  final CollectionId collectionId;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;

  ToDoDetailCubit({
    required this.collectionId,
    required this.loadToDoEntryIdsForCollection,
  }) : super(ToDoDetailCubitStateLoading());

  Future<void> fetch() async {
    emit(ToDoDetailCubitStateLoading());
    try {
      final result = await loadToDoEntryIdsForCollection(
          LoadToDoEntryIdsParams(collectionId: collectionId));
      result.fold((left) => emit(ToDoDetailCubitStateError()),
          (right) => emit(ToDoDetailCubitStateLoaded(entryIds: right)));
    } on Exception catch (e) {
      emit(ToDoDetailCubitStateError());
    }
  }
}
