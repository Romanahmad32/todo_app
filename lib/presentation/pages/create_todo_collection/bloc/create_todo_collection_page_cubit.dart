import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/use_cases/create_todo_collection.dart';

part 'create_todo_collection_page_cubit_state.dart';

class CreateToDoCollectionPageCubit
    extends Cubit<CreateToDoCollectionPageState> {
  final CreateToDoCollection createToDoCollection;

  CreateToDoCollectionPageCubit({required this.createToDoCollection})
      : super(const CreateToDoCollectionPageState());

  void titleChanged(String title) {
    print('titleChanged: $title');
    emit(state.copyWith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copyWith(color: color));
  }

  Future<void> submit() async {
    final int parsedColorIndex = int.tryParse(state.color ?? '') ?? 0;
    await createToDoCollection(
      CreateToDoCollectionParams(
          collection: ToDoCollection.empty().copyWith(
        title: state.title,
        color: ToDoColor(colorIndex: parsedColorIndex),
      )),
    );
  }
}
