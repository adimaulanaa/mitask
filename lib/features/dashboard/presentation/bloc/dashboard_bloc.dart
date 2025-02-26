
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart'; // Tambahkan import dartz
import 'package:mitask/core/error/failures.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/data/repositories/dashboard_repository.dart';
import 'bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepo;

  DashboardBloc({required DashboardRepository dashboardRepo})
      : _dashboardRepo = dashboardRepo,
        super(DashboardInitial()) {
    on<GetDashboard>(_onDashboard);
    on<GetTask>(_onTask);
  }

  void _onDashboard(GetDashboard event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());

    final Either<Failure, List<DateModel>> result =
        await _dashboardRepo.dashboard();
    result.fold(
      (failure) => emit(DashboardError(mapFailureToMessage(failure))),
      (success) => emit(DashboardLoaded(success)),
    );
  }

  void _onTask(GetTask event, Emitter<DashboardState> emit) async {
    emit(TaskLoading());

    final Either<Failure, List<TaskModel>> result =
        await _dashboardRepo.task(event.date);
    result.fold(
      (failure) => emit(TaskError(mapFailureToMessage(failure))),
      (success) => emit(TaskLoaded(success)),
    );
  }
}
