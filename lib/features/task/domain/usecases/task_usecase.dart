import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/domain/repositories/task_repository.dart';

class TaskUseCase {
  final TaskRepository repository;

  TaskUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call() async {
    // Panggil fungsi login dari Repository
    return await repository.get();
  }
}