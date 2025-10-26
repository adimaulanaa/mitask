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

class CreateLoading extends TaskState {}
class CreateLoaded extends TaskState {
  final String data;

  const CreateLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class CreateFailure extends TaskState {
  final String message;

  const CreateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class FilterLoading extends TaskState {}
class FilterLoaded extends TaskState {
  final List<TaskEntity> data;

  const FilterLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class FilterFailure extends TaskState {
  final String message;

  const FilterFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UpdateLoading extends TaskState {}
class UpdateLoaded extends TaskState {
  final String data;

  const UpdateLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class UpdateFailure extends TaskState {
  final String message;

  const UpdateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteLoading extends TaskState {}
class DeleteLoaded extends TaskState {
  final String data;

  const DeleteLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class DeleteFailure extends TaskState {
  final String message;

  const DeleteFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChecklistLoading extends TaskState {}
class ChecklistLoaded extends TaskState {
  final String data;

  const ChecklistLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class ChecklistFailure extends TaskState {
  final String message;

  const ChecklistFailure({required this.message});

  @override
  List<Object?> get props => [message];
}