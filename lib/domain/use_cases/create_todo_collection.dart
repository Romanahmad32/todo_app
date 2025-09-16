import 'package:dartz/dartz.dart';
import 'package:todo_app/core/use_cases/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class CreateToDoCollection
    implements UseCase<bool, CreateToDoCollectionParams> {
  final ToDoRepository toDoRepository;

  CreateToDoCollection({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(CreateToDoCollectionParams params) async {
    try {
      final createdEntry =
          await toDoRepository.createToDoCollection(params.collection);

      return createdEntry.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}

class CreateToDoCollectionParams extends Params {
  final ToDoCollection collection;

  CreateToDoCollectionParams({required this.collection});

  @override
  List<Object?> get props => [collection];
}
