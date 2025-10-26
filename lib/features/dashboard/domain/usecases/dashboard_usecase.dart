import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:mitask/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardUseCase {
  final DashboardRepository repository;

  DashboardUseCase(this.repository);

  Future<Either<Failure, DashboardEntity>> call() async {
    // Panggil fungsi login dari Repository
    return await repository.dash();
  }
}