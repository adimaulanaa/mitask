import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/features/task/domain/usecases/task_usecase.dart';
import 'package:mitask/features/task/presentation/bloc/task_event.dart';
import 'package:mitask/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUseCase task;

  TaskBloc({
    required this.task,
  }) : super(TaskInitial()) {
    on<TaskRequested>(_onTaskRequested);
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
}
