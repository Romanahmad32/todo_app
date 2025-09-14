import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

import '../../domain/entities/todo_color.dart';

class ToDoRepositoryMock implements ToDoRepository {
  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    final list = List<ToDoCollection>.generate(
        10,
        (index) => ToDoCollection(
              id: CollectionId.fromUniqueString(index.toString()),
              title: 'title $index',
              color: ToDoColor(
                  colorIndex: index % ToDoColor.predefinedColors.length),
            ));
    return Future.delayed(
      Duration(milliseconds: 200),
      () => Right(list),
    );
  }
}
