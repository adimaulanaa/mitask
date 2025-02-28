import 'package:equatable/equatable.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/data/models/response_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class TaskLoading extends DashboardState {}

class CreateTaskLoading extends DashboardState {}

class ChecklistLoading extends DashboardState {}

class DeleteTaskLoading extends DashboardState {}

class ChangeDateTaskLoading extends DashboardState {}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError(this.error);

  @override
  List<Object> get props => [error];
}

class DashboardLoaded extends DashboardState {
  final List<DateModel> data;
  const DashboardLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class TaskError extends DashboardState {
  final String error;

  const TaskError(this.error);

  @override
  List<Object> get props => [error];
}

class TaskLoaded extends DashboardState {
  final List<TaskModel> data;
  const TaskLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class CreateTaskError extends DashboardState {
  final String error;

  const CreateTaskError(this.error);

  @override
  List<Object> get props => [error];
}

class CreateTaskSuccess extends DashboardState {
  final ResponseModel data;
  const CreateTaskSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ChecklistError extends DashboardState {
  final String error;

  const ChecklistError(this.error);

  @override
  List<Object> get props => [error];
}

class ChecklistSuccess extends DashboardState {
  final ResponseModel data;
  const ChecklistSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class DeleteTaskError extends DashboardState {
  final String error;

  const DeleteTaskError(this.error);

  @override
  List<Object> get props => [error];
}

class DeleteTaskSuccess extends DashboardState {
  final ResponseModel data;
  const DeleteTaskSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ChangeDateTaskError extends DashboardState {
  final String error;

  const ChangeDateTaskError(this.error);

  @override
  List<Object> get props => [error];
}

class ChangeDateTaskSuccess extends DashboardState {
  final ResponseModel data;
  const ChangeDateTaskSuccess(this.data);

  @override
  List<Object> get props => [data];
}