import 'package:dartz/dartz.dart';
import 'package:mitask/core/error/failures.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_local_source.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/data/models/response_model.dart';
import 'package:mitask/features/dashboard/data/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalSource dataLocalSource;

  DashboardRepositoryImpl({required this.dataLocalSource});

  @override
  Future<Either<Failure, List<DateModel>>> dashboard() async {
    try {
      final result = await dataLocalSource.dashboard();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> task(String date) async {
    try {
      final result = await dataLocalSource.taskByDate(date);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> createTask(TaskModel data) async {
    try {
      final result = await dataLocalSource.createTask(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, ResponseModel>> checklist(String id, String data) async {
    try {
      final result = await dataLocalSource.checklist(id, data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, ResponseModel>> deleteTask(String id) async {
    try {
      final result = await dataLocalSource.deleteTask(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
