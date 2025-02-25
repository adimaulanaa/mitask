// File: lib/features/auth/data/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:mitask/core/error/failures.dart';
import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<DashboardModel>>> dashboard();
}
