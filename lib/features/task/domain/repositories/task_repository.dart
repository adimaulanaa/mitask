import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/domain/usecases/params/create_task_params.dart';
import 'package:mitask/features/task/domain/usecases/params/task_filter_params.dart';
import 'package:mitask/features/task/domain/usecases/params/update_task_params.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> get();
  Future<Either<Failure, String>> create(CreateTaskParams params);
  Future<Either<Failure, String>> update(UpdateTaskParams params);
  Future<Either<Failure, List<TaskEntity>>> filter(TaskFilterParams params);
  Future<Either<Failure, String>> delete(String id);
}
