
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart'; // Tambahkan import dartz
import 'package:mitask/core/error/failures.dart';
import 'package:mitask/features/report/data/models/report_model.dart';
import 'package:mitask/features/report/data/repositories/report_repository.dart';
import 'bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository _reportRepo;

  ReportBloc({required ReportRepository reportRepo})
      : _reportRepo = reportRepo,
        super(ReportInitial()) {
    on<GetReport>(_onReport);
    on<ExportTask>(_onExportTask);
  }

  void _onReport(GetReport event, Emitter<ReportState> emit) async {
    emit(ReportLoading());

    final Either<Failure, List<ReportModel>> result =
        await _reportRepo.report(event.start, event.end);
    result.fold(
      (failure) => emit(ReportError(mapFailureToMessage(failure))),
      (success) => emit(ReportLoaded(success)),
    );
  }

  void _onExportTask(ExportTask event, Emitter<ReportState> emit) async {
    emit(ReportLoading());

    final Either<Failure, String> result =
        await _reportRepo.export();
    result.fold(
      (failure) => emit(ExportTaskError(mapFailureToMessage(failure))),
      (success) => emit(ExportTaskSuccess(success)),
    );
  }
}
