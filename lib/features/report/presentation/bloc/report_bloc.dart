import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/features/report/domain/usecases/report_usecase.dart';
import 'package:mitask/features/report/presentation/bloc/report_event.dart';
import 'package:mitask/features/report/presentation/bloc/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportUseCase report;

  ReportBloc({
    required this.report,
  }) : super(ReportInitial()) {
    on<ReportRequested>(_onReportRequested);
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
}
