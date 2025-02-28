// File: lib/features/auth/data/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:mitask/core/error/failures.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/dashboard/data/models/response_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<DateModel>>> dashboard();
  Future<Either<Failure, List<TaskModel>>> task(String date);
  Future<Either<Failure, ResponseModel>> createTask(TaskModel data);
  Future<Either<Failure, ResponseModel>> checklist(String id, String data);
  Future<Either<Failure, ResponseModel>> deleteTask(String id);
}
