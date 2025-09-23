import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/components/todo_entry_item/todo_entry_item.dart';
import 'package:todo_app/presentation/pages/create_todo_entry/create_todo_entry_page.dart';

import '../../../../domain/entities/unique_id.dart';
import '../blocs/todo_detail_cubit.dart';


class TodoDetailLoaded extends StatelessWidget {
  final List<EntryId> entryIds;
  final CollectionId collectionId;

  const TodoDetailLoaded({
    super.key,
    required this.entryIds,
    required this.collectionId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: entryIds.length,
              itemBuilder: (context, index) => ToDoEntryItemProvider(
                collectionId: collectionId,
                entryId: entryIds[index],
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: FloatingActionButton(
                key: Key('create-todo-entry'),
                heroTag: 'create-todo-entry',
                child: Icon(Icons.add),
                onPressed: () {
                  context.pushNamed(
                    CreateTodoEntryPage.pageConfig.name,
                    extra: CreateToDoEntryPageExtra(
                      collectionId: collectionId,
                      todoEntryItemAddedCallback: () =>
                          context.read<ToDoDetailCubit>().fetch(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
