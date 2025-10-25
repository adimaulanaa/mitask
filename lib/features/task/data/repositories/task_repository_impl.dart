import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mitask/core/network/failure_mapper.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/task/data/datasources/task_local_datasource.dart';
import 'package:mitask/features/task/data/datasources/task_remote_datasource.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';
import 'package:mitask/features/task/domain/repositories/task_repository.dart';
import 'package:mitask/features/task/domain/usecases/params/create_task_params.dart';
import 'package:mitask/features/task/domain/usecases/params/task_filter_params.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDatasource;

  TaskRepositoryImpl(
    this.remoteDataSource,
    this.localDatasource,
  );

  @override
  Future<Either<Failure, List<TaskEntity>>> get() async {
    try {
      final result = await localDatasource.get();
      return Right(result);
    } catch (e) {
      if (kDebugMode) {
        print(mapExceptionToFailure(e).message);
      }
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> create(CreateTaskParams params) async {
    try {
      final result = await localDatasource.create(params);
      return Right(result);
    } catch (e) {
      if (kDebugMode) {
        print(mapExceptionToFailure(e).message);
      }
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> filter(TaskFilterParams params) async {
    try {
      final result = await localDatasource.filter(params);
      return Right(result);
    } catch (e) {
      if (kDebugMode) {
        print(mapExceptionToFailure(e).message);
      }
      return Left(mapExceptionToFailure(e));
    }
  }
}
