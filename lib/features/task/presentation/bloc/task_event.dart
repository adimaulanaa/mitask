import 'package:equatable/equatable.dart';
import 'package:mitask/features/task/domain/usecases/params/create_task_params.dart';
import 'package:mitask/features/task/domain/usecases/params/task_filter_params.dart';
import 'package:mitask/features/task/domain/usecases/params/update_task_params.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class TaskRequested extends TaskEvent {}

class CreateRequested extends TaskEvent {
  final CreateTaskParams data;
  const CreateRequested({required this.data});

  @override
  List<Object> get props => [data];
}

class FilterRequested extends TaskEvent {
  final TaskFilterParams data;
  const FilterRequested({required this.data});

  @override
  List<Object> get props => [data];
}

class UpdateRequested extends TaskEvent {
  final UpdateTaskParams data;
  const UpdateRequested({required this.data});

  @override
  List<Object> get props => [data];
}

class DeleteRequested extends TaskEvent {
  final String id;
  const DeleteRequested({required this.id});

  @override
  List<Object> get props => [id];
}