import 'package:dartz/dartz.dart';
import 'package:todo_app/core/use_cases/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class LoadToDoCollections implements UseCase<List<ToDoCollection>, NoParams> {
  final ToDoRepository toDoRepository;

  LoadToDoCollections({required this.toDoRepository});

  @override
  Future<Either<Failure, List<ToDoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = await toDoRepository.readToDoCollections();
      return loadedCollections.fold(
          (failure) => Left(failure), (collections) => Right(collections));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
