import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<Either<Failure, String>> call(String id) {
    return repository.delete(id);
  }
}
