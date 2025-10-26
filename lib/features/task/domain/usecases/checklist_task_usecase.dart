import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/task/domain/usecases/params/checklist_task_params.dart';
import '../repositories/task_repository.dart';

class ChecklistTaskUseCase {
  final TaskRepository repository;

  ChecklistTaskUseCase(this.repository);

  Future<Either<Failure, String>> call(ChecklistTaskParams params) {
    return repository.checklist(params);
  }
}
