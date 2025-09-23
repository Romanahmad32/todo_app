import 'package:equatable/equatable.dart';

class ToDoEntryModel extends Equatable {
  final String id;
  final String description;
  final bool isDone;

  const ToDoEntryModel({
    required this.id,
    required this.description,
    required this.isDone,
  });


  factory ToDoEntryModel.fromJson(Map<String, dynamic> json) {
    return ToDoEntryModel(
      id: json['id'],
      description: json['description'],
      isDone: json['isDone'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [description, isDone, id];
}
