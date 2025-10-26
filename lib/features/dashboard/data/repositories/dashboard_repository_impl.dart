import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mitask/core/network/failure_mapper.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:mitask/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:mitask/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDatasource;

  DashboardRepositoryImpl(
    this.remoteDataSource,
    this.localDatasource,
  );

  @override
  Future<Either<Failure, DashboardEntity>> dash() async {

    try {
      final result = await localDatasource.dash();
      return Right(result);
    } catch (e) {
      if (kDebugMode) {
        print(mapExceptionToFailure(e).message);
      }
      return Left(mapExceptionToFailure(e));
    }
  }
}
