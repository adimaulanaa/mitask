import 'package:equatable/equatable.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError(this.error);

  @override
  List<Object> get props => [error];
}

class DashboardLoaded extends DashboardState {
  final List<DashboardModel> data;
  const DashboardLoaded(this.data);

  @override
  List<Object> get props => [data];
}
