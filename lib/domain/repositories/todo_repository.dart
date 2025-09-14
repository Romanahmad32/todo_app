import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';

import '../failures/failures.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();
}
