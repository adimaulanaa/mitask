import 'package:equatable/equatable.dart';
import 'package:mitask/features/task/domain/usecases/params/create_task_params.dart';

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
