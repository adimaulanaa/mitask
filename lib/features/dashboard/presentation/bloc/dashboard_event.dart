import 'package:equatable/equatable.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetDashboard extends DashboardEvent {
  const GetDashboard();

  @override
  List<Object> get props => [];
}

class GetTask extends DashboardEvent {
  final String date;
  const GetTask({required this.date});

  @override
  List<Object> get props => [];
}

class CreateTask extends DashboardEvent {
  final TaskModel data;
  const CreateTask({required this.data});

  @override
  List<Object> get props => [];
}

class Checklist extends DashboardEvent {
  final String id;
  final String data;
  const Checklist({required this.id, required this.data});

  @override
  List<Object> get props => [];
}

class DeleteTask extends DashboardEvent {
  final String id;
  const DeleteTask({required this.id});

  @override
  List<Object> get props => [];
}

class ChangeDateTask extends DashboardEvent {
  final String id;
  final String date;
  const ChangeDateTask({required this.id, required this.date});

  @override
  List<Object> get props => [];
}

