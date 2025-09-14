import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/todo_entry.dart';
import '../../../../domain/entities/unique_id.dart';
import '../../../../domain/use_cases/load_todo_entry.dart';
import '../../../../domain/use_cases/update_todo_entry.dart';

part 'todo_entry_item_cubit_state.dart';

class ToDoEntryItemCubit extends Cubit<ToDoEntryItemState> {
  final EntryId entryId;
  final CollectionId collectionId;
  final LoadToDoEntry loadToDoEntry;

  final UpdateToDoEntry updateToDoEntry;

  ToDoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadToDoEntry,
    required this.updateToDoEntry,
  }) : super(ToDoEntryItemLoadingState());

  Future<void> fetch() async {
    try {
      final entry = await loadToDoEntry(
        LoadToDoEntryParams(
          collectionId: collectionId,
          entryId: entryId,
        ),
      );
      entry.fold(
        (left) => emit(ToDoEntryItemErrorState()),
        (right) => emit(ToDoEntryItemLoadedState(entry: right)),
      );
    } on Exception {
      emit(ToDoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      final entry = await (updateToDoEntry(
        UpdateToDoEntryParams(
          collectionId: collectionId,
          entryId: entryId,
        ),
      ));
      entry.fold(
        (left) => emit(ToDoEntryItemErrorState()),
        (right) => emit(ToDoEntryItemLoadedState(entry: right)),
      );
    } on Exception {
      emit(ToDoEntryItemErrorState());
    }
  }
}
