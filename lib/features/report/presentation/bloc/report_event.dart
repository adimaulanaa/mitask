import 'package:equatable/equatable.dart';
import 'package:mitask/features/report/domain/usecases/params/all_notes_params.dart';
import 'package:mitask/features/report/domain/usecases/params/report_filter_params.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class ReportRequested extends ReportEvent {
  final ReportFilterParams data;
  const ReportRequested({required this.data});

  @override
  List<Object> get props => [data];
}

class AllNotesRequested extends ReportEvent {
  final AllNotesParams data;
  const AllNotesRequested({required this.data});

  @override
  List<Object> get props => [data];
}

