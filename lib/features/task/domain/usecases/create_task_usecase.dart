import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import '../repositories/task_repository.dart';
import 'params/create_task_params.dart';

class CreateTaskUseCase {
  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  Future<Either<Failure, String>> call(CreateTaskParams params) {
    return repository.create(params);
  }
}
