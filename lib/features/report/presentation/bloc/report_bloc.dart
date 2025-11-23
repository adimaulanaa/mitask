import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/features/report/domain/usecases/all_note_usecase.dart';
import 'package:mitask/features/report/domain/usecases/report_usecase.dart';
import 'package:mitask/features/report/presentation/bloc/report_event.dart';
import 'package:mitask/features/report/presentation/bloc/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportUseCase report;
  final AllNotesUseCase all;

  ReportBloc({
    required this.report,
    required this.all,
  }) : super(ReportInitial()) {
    on<ReportRequested>(_onReportRequested);
    on<AllNotesRequested>(_onAllNotesRequested);
  }

  Future<void> _onReportRequested(
    ReportRequested event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());

    final result = await report(event.data);

    result.fold(
      (failure) => emit(ReportFailure(message: failure.message)),
      (success) => emit(ReportLoaded(data: success)),
    );
  }

  Future<void> _onAllNotesRequested(
    AllNotesRequested event,
    Emitter<ReportState> emit,
  ) async {
    emit(AllNotesLoading());

    final result = await all(event.data);

    result.fold(
      (failure) => emit(AllNotesFailure(message: failure.message)),
      (success) => emit(AllNotesLoaded(data: success)),
    );
  }
}
