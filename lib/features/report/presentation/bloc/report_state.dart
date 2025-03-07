import 'package:equatable/equatable.dart';
import 'package:mitask/features/report/data/models/report_model.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ExportTaskLoading extends ReportState {}

class ReportError extends ReportState {
  final String error;

  const ReportError(this.error);

  @override
  List<Object> get props => [error];
}

class ReportLoaded extends ReportState {
  final List<ReportModel> data;
  const ReportLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ExportTaskError extends ReportState {
  final String error;

  const ExportTaskError(this.error);

  @override
  List<Object> get props => [error];
}

class ExportTaskSuccess extends ReportState {
  final String success;

  const ExportTaskSuccess(this.success);

  @override
  List<Object> get props => [success];
}
