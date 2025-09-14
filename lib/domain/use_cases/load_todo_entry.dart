import 'package:dartz/dartz.dart';
import 'package:todo_app/core/use_cases/use_case.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';

import '../entities/unique_id.dart';
import '../failures/failures.dart';
import '../repositories/todo_repository.dart';

class LoadToDoEntry implements UseCase<ToDoEntry, ToDoEntryParams> {
  final ToDoRepository toDoRepository;

  const LoadToDoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryParams params) async {
    try {
      final loadedEntry = await toDoRepository.readToDoEntry(
          params.collectionId, params.entryId);

      return loadedEntry.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}

class ToDoEntryParams extends Params {
  final String? description;
  final CollectionId collectionId;
  final EntryId entryId;

  ToDoEntryParams({
    required this.collectionId,
    this.description,
    required this.entryId,
  }) : super();

  @override
  List<Object?> get props => [collectionId, entryId];
}
