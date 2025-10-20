import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardUseCase dash;

  DashboardBloc({
    required this.dash,
  }) : super(DashboardInitial()) {
    on<DashboardRequested>(_onDashRequested);
  }

  Future<void> _onDashRequested(
    DashboardRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    final result = await dash();

    result.fold(
      (failure) => emit(DashboardFailure(message: failure.message)),
      (success) => emit(DashboardSucces(data: success)),
    );
  }
}
