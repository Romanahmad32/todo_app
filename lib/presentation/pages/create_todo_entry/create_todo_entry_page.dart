import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/presentation/core/form_value.dart';
import 'package:todo_app/presentation/pages/detail/todo_detail_page.dart';

import '../../../domain/repositories/todo_repository.dart';
import '../../core/page_config.dart';
import 'bloc/create_todo_entry_page_cubit.dart';

class CreateToDoEntryPageExtra {
  final CollectionId collectionId;
  final ToDoEntryItemAddedCallback todoEntryItemAddedCallback;

  CreateToDoEntryPageExtra({
    required this.collectionId,
    required this.todoEntryItemAddedCallback,
  });
}

class CreateTodoEntryPageProvider extends StatelessWidget {
  final CollectionId collectionId;
  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;

  const CreateTodoEntryPageProvider({
    super.key,
    required this.collectionId,
    required this.toDoEntryItemAddedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoEntryPageCubit>(
      create: (context) => CreateToDoEntryPageCubit(
          collectionId: collectionId,
          createToDoEntry: CreateToDoEntry(
              toDoRepository: RepositoryProvider.of<ToDoRepository>(context))),
      child: CreateTodoEntryPage(
        toDoEntryItemAddedCallback: toDoEntryItemAddedCallback,
      ),
    );
  }
}

class CreateTodoEntryPage extends StatefulWidget {
  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;

  const CreateTodoEntryPage(
      {super.key, required this.toDoEntryItemAddedCallback});

  static const PageConfig pageConfig = PageConfig(
    name: 'create_todo_entry',
    icon: Icons.add_circle_rounded,
    child: Placeholder(),
  );

  @override
  State<CreateTodoEntryPage> createState() => _CreateTodoEntryPageState();
}

class _CreateTodoEntryPageState extends State<CreateTodoEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'description'),
              validator: (value) {
                final currentValidationState = context
                        .read<CreateToDoEntryPageCubit>()
                        .state
                        .description
                        ?.validationStatus ??
                    ValidationStatus.pending;

                switch (currentValidationState) {
                  case ValidationStatus.error:
                    return 'This field needs at least two characters to be valid';
                  case ValidationStatus.success:
                  case ValidationStatus.pending:
                    return null;
                }
              },
              onChanged: (value) {
                context
                    .read<CreateToDoEntryPageCubit>()
                    .descriptionChanged(description: value);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate() ?? false;

                if (isValid) {
                  context.read<CreateToDoEntryPageCubit>().submit();
                  widget.toDoEntryItemAddedCallback();
                  context.pop();
                }
              },
              child: const Text('Save entry'),
            )
          ],
        ),
      ),
    );
  }
}
