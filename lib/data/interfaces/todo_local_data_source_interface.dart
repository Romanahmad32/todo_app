import 'package:todo_app/domain/entities/todo_entry.dart';

import '../models/todo_entry_model.dart';

abstract class ToDoLocalDataSourceInterface {
  Future<ToDoEntryModel> getToDoEntry(
      {required String collectionId, required String entryId});

  Future<List<String>> getToDoEntryIds({required String collectionId});

  Future<ToDoCollectionModel> getToDoCollection({required String collectionId});

  Future<List<String>> getToDoCollectionIds();

  Future<bool> createToDoEntry({required collectionId, required ToDoEntryModel entry});

  Future<bool> createToDoCollection({required ToDoCollectionModel collection});

  Future<ToDoEntryModel> updateToDoEntry({required String collectionId,required String entryId});
}
