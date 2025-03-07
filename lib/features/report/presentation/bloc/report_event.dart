import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class GetReport extends ReportEvent {
  final String start;
  final String end;
  const GetReport({required this.start, required this.end});

  @override
  List<Object> get props => [];
}

class ExportTask extends ReportEvent {
  const ExportTask();

  @override
  List<Object> get props => [];
}

