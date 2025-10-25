import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/domain/usecases/params/task_filter_params.dart';
import '../repositories/task_repository.dart';

class TaskFilterUseCase {
  final TaskRepository repository;

  TaskFilterUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call(TaskFilterParams params) {
    return repository.filter(params);
  }
}
