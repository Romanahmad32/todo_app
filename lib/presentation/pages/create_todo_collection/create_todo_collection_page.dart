import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/create_todo_collection.dart';
import 'package:todo_app/presentation/core/page_config.dart';
import 'package:todo_app/presentation/pages/create_todo_collection/bloc/create_todo_collection_page_cubit.dart';

import '../../../domain/entities/unique_id.dart';
import '../detail/todo_detail_page.dart';

class CreateTodoCollectionPageProvider extends StatelessWidget {
  const CreateTodoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoCollectionPageCubit>(
      create: (context) => CreateToDoCollectionPageCubit(
        createToDoCollection: CreateToDoCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: CreateTodoCollectionPage(),
    );
  }
}

class CreateTodoCollectionPage extends StatefulWidget {
  const CreateTodoCollectionPage({super.key});

  static const PageConfig pageConfig = PageConfig(
    name: 'create_todo_collection',
    icon: Icons.add_task_rounded,
    child: CreateTodoCollectionPageProvider(),
  );

  @override
  State<CreateTodoCollectionPage> createState() =>
      _CreateTodoCollectionPageState();
}

class _CreateTodoCollectionPageState extends State<CreateTodoCollectionPage> {
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
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) => context
                  .read<CreateToDoCollectionPageCubit>()
                  .titleChanged(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Color'),
              onChanged: (value) => context
                  .read<CreateToDoCollectionPageCubit>()
                  .colorChanged(value),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsedColorIndex = int.tryParse(value);
                  if (parsedColorIndex == null ||
                      parsedColorIndex < 0 ||
                      parsedColorIndex > ToDoColor.predefinedColors.length) {
                    return 'Only Number between 0 and ${ToDoColor.predefinedColors.length} are allowed';
                  }
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate();
                if (isValid == true) {
                  context.read<CreateToDoCollectionPageCubit>().submit().then(
                        (_) => context.pop(true),
                      );
                 }
              },
              child: const Text('Save Collection'),
            )
          ],
        ),
      ),
    );
  }
}
