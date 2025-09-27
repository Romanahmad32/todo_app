import 'package:dartz/dartz.dart';
import 'package:todo_app/data/exeptions/exeptions.dart';
import 'package:todo_app/data/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/data/models/todo_entry_model.dart';

import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';

import 'package:todo_app/domain/entities/todo_entry.dart';

import 'package:todo_app/domain/entities/unique_id.dart';

import 'package:todo_app/domain/failures/failures.dart';

import '../../domain/repositories/todo_repository.dart';
import '../models/todo_collection_model.dart';

class ToDoRepositoryLocal extends ToDoRepository {
  final ToDoLocalDataSourceInterface localDataSource;

  ToDoRepositoryLocal({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection collection) async {
    try {
      final result = await localDataSource.createToDoCollection(
        collection: toDoCollectionToModel(collection),
      );
      return Right(result);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
      CollectionId collectionId, ToDoEntry entry) {
    try {
      final result = localDataSource.createToDoEntry(
        collectionId: collectionId.value,
        entry: toDoEntryToModel(entry),
      );
      return Future.value(Right(true));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() async {
    try {
      final collectionIds = await localDataSource.getToDoCollectionIds();
      final List<ToDoCollection> collections = [];
      for (String collectionId in collectionIds) {
        final collection =
            await localDataSource.getToDoCollection(collectionId: collectionId);
        collections.add(toDoCollectionFromModel(collection));
      }
      return Right(collections);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final result = await localDataSource.getToDoEntry(
        collectionId: collectionId.value,
        entryId: entryId.value,
      );
      return Right(toDoEntryFromModel(result));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) async {
    try {
      final result = await localDataSource.getToDoEntryIds(
          collectionId: collectionId.value);
      List<EntryId> entryIds = [];
      for (String entryId in result) {
        entryIds.add(EntryId.fromUniqueString(entryId));
      }
      return Right(entryIds);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final result = await localDataSource.updateToDoEntry(
          collectionId: collectionId.value, entryId: entryId.value);
      return Right(toDoEntryFromModel(result));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}

// entry to model
ToDoEntryModel toDoEntryToModel(ToDoEntry entry) {
  return ToDoEntryModel(
      id: entry.id.value, description: entry.description, isDone: entry.isDone);
}

// model to entry
ToDoEntry toDoEntryFromModel(ToDoEntryModel model) {
  return ToDoEntry(
      id: EntryId.fromUniqueString(model.id),
      description: model.description,
      isDone: model.isDone);
}

// collection to model
ToDoCollectionModel toDoCollectionToModel(ToDoCollection collection) {
  return ToDoCollectionModel(
    id: collection.id.value,
    colorIndex: collection.color.colorIndex,
    title: collection.title,
  );
}

// model to collection
ToDoCollection toDoCollectionFromModel(ToDoCollectionModel model) {
  return ToDoCollection(
    id: CollectionId.fromUniqueString(model.id),
    color: ToDoColor(colorIndex: model.colorIndex),
    title: model.title,
  );
}
