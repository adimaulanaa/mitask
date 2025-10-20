import 'package:equatable/equatable.dart';
import 'package:mitask/features/dashboard/data/models/date_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}
class DashboardSucces extends DashboardState {
  final List<DateModel> data;

  const DashboardSucces({required this.data});

  @override
  List<Object?> get props => [data];
}
class DashboardFailure extends DashboardState {
  final String message;

  const DashboardFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
