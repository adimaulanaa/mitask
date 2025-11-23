import 'package:equatable/equatable.dart';
import 'package:mitask/features/report/domain/entities/report_entity.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}
class ReportLoaded extends ReportState {
  final ReportEntity data;

  const ReportLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class ReportFailure extends ReportState {
  final String message;

  const ReportFailure({required this.message});

  @override
  List<Object?> get props => [message];
}


class AllNotesLoading extends ReportState {}
class AllNotesLoaded extends ReportState {
  final List<TaskEntity> data;

  const AllNotesLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}
class AllNotesFailure extends ReportState {
  final String message;

  const AllNotesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
