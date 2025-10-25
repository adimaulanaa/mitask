import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/features/task/domain/usecases/create_task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/task_filter_usecase.dart';
import 'package:mitask/features/task/domain/usecases/task_usecase.dart';
import 'package:mitask/features/task/presentation/bloc/task_event.dart';
import 'package:mitask/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUseCase task;
  final CreateTaskUseCase create;
  final TaskFilterUseCase filter;

  TaskBloc({required this.task, required this.create, required this.filter}) : super(TaskInitial()) {
    on<TaskRequested>(_onTaskRequested);
    on<CreateRequested>(_onCreateRequested);
    on<FilterRequested>(_onFilterRequested);
  }

  Future<void> _onTaskRequested(
    TaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());

    final result = await task();

    result.fold(
      (failure) => emit(TaskFailure(message: failure.message)),
      (success) => emit(TaskLoaded(data: success)),
    );
  }

  Future<void> _onCreateRequested(
    CreateRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateLoading());

    final result = await create(event.data);

    result.fold(
      (failure) => emit(CreateFailure(message: failure.message)),
      (success) => emit(CreateLoaded(data: success)),
    );
  }

  Future<void> _onFilterRequested(
    FilterRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(FilterLoading());

    final result = await filter(event.data);

    result.fold(
      (failure) => emit(FilterFailure(message: failure.message)),
      (success) => emit(FilterLoaded(data: success)),
    );
  }
}
