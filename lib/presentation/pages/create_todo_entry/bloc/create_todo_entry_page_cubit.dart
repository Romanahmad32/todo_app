import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/presentation/core/form_value.dart';

import '../../../../domain/use_cases/create_todo_entry.dart';

part 'create_todo_entry_page_state.dart';

class CreateToDoEntryPageCubit extends Cubit<CreateToDoEntryPageState> {
  final CollectionId collectionId;

  final CreateToDoEntry createToDoEntry;

  CreateToDoEntryPageCubit(
      {required this.collectionId, required this.createToDoEntry})
      : super(const CreateToDoEntryPageState());

  void descriptionChanged({String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    if (description == null || description.isEmpty) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }
    emit(state.copyWith(
        description:
            FormValue(value: description, validationStatus: currentStatus)));
  }

  void submit() {
    createToDoEntry(
      CreateToDoEntryParams(
        entry: ToDoEntry.empty().copyWith(
          description: state.description?.value,
        ),
      ),
    );
  }
}
