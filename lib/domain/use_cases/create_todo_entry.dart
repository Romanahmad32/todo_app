import 'package:dartz/dartz.dart';
import 'package:todo_app/core/use_cases/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class CreateToDoEntry
    implements UseCase<bool, CreateToDoEntryParams> {
  final ToDoRepository toDoRepository;

  CreateToDoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(CreateToDoEntryParams params) async {
    try {
      final createdEntry =
          await toDoRepository.createToDoEntry(params.collectionId,params.entry);

      return createdEntry.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}

class CreateToDoEntryParams extends Params {
  final CollectionId collectionId;
  final ToDoEntry entry;

  CreateToDoEntryParams({required this.entry,required this.collectionId});

  @override
  List<Object?> get props => [entry,collectionId];
}
