import 'package:equatable/equatable.dart';

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

