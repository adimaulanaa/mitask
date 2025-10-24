import 'package:equatable/equatable.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}
class TaskLoaded extends TaskState {
  final List<TaskEntity> data;

  const TaskLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class TaskFailure extends TaskState {
  final String message;

  const TaskFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
