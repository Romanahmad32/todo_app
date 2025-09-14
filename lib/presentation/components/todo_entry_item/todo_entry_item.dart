import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/presentation/components/todo_entry_item/view_states/todo_entry_item_error.dart';
import 'package:todo_app/presentation/components/todo_entry_item/view_states/todo_entry_item_loaded.dart';
import 'package:todo_app/presentation/components/todo_entry_item/view_states/todo_entry_item_loading.dart';

import '../../../domain/entities/unique_id.dart';
import '../../../domain/repositories/todo_repository.dart';
import 'bloc/todo_entry_item_cubit.dart';

class ToDoEntryItemProvider extends StatelessWidget {
  final CollectionId collectionId;
  final EntryId entryId;

  const ToDoEntryItemProvider({
    super.key,
    required this.collectionId,
    required this.entryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoEntryItemCubit>(
      create: (context) => ToDoEntryItemCubit(
          collectionId: collectionId,
          entryId: entryId,
          loadToDoEntry: LoadToDoEntry(
            toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
          ),
          updateToDoEntry: UpdateToDoEntry(
            toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
          ))
        ..fetch(),
      child: ToDoEntryItem(),
    );
  }
}

class ToDoEntryItem extends StatelessWidget {
  const ToDoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoEntryItemCubit, ToDoEntryItemState>(
      builder: (context, state) {
        if (state is ToDoEntryItemLoadingState) {
          return const ToDoEntryItemLoading();
        }
        if (state is ToDoEntryItemLoadedState) {
          return ToDoEntryItemLoaded(
            entry: state.entry,
            onChanged: (_) => context.read<ToDoEntryItemCubit>().update(),
          );
        }
        return const ToDoEntryItemError();
      },
    );
  }
}
