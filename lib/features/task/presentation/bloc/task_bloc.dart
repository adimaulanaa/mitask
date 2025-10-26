import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitask/features/task/domain/usecases/checklist_task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/create_task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/task_filter_usecase.dart';
import 'package:mitask/features/task/domain/usecases/task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/update_task_usecase.dart';
import 'package:mitask/features/task/presentation/bloc/task_event.dart';
import 'package:mitask/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUseCase task;
  final CreateTaskUseCase create;
  final TaskFilterUseCase filter;
  final UpdateTaskUseCase update;
  final DeleteTaskUseCase delete;
  final ChecklistTaskUseCase checklist;

  TaskBloc({
    required this.task,
    required this.create,
    required this.filter,
    required this.update,
    required this.delete,
    required this.checklist,
  }) : super(TaskInitial()) {
    on<TaskRequested>(_onTaskRequested);
    on<CreateRequested>(_onCreateRequested);
    on<FilterRequested>(_onFilterRequested);
    on<UpdateRequested>(_onUpdateRequested);
    on<DeleteRequested>(_onDeleteRequested);
    on<ChecklistRequested>(_onChecklistRequested);
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

  Future<void> _onUpdateRequested(
    UpdateRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(UpdateLoading());

    final result = await update(event.data);

    result.fold(
      (failure) => emit(UpdateFailure(message: failure.message)),
      (success) => emit(UpdateLoaded(data: success)),
    );
  }

  Future<void> _onDeleteRequested(
    DeleteRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(DeleteLoading());

    final result = await delete(event.id);

    result.fold(
      (failure) => emit(DeleteFailure(message: failure.message)),
      (success) => emit(DeleteLoaded(data: success)),
    );
  }

  Future<void> _onChecklistRequested(
    ChecklistRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(ChecklistLoading());

    final result = await checklist(event.data);

    result.fold(
      (failure) => emit(ChecklistFailure(message: failure.message)),
      (success) => emit(ChecklistLoaded(data: success)),
    );
  }
}
