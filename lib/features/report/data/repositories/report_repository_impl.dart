import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mitask/core/network/failure_mapper.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/report/data/datasources/report_local_datasource.dart';
import 'package:mitask/features/report/data/datasources/report_remote_datasource.dart';
import 'package:mitask/features/report/domain/entities/report_entity.dart';
import 'package:mitask/features/report/domain/repositories/report_repository.dart';
import 'package:mitask/features/report/domain/usecases/params/report_filter_params.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource remoteDataSource;
  final ReportLocalDataSource localDatasource;

  ReportRepositoryImpl(
    this.remoteDataSource,
    this.localDatasource,
  );

  @override
  Future<Either<Failure, ReportEntity>> report(ReportFilterParams params) async {

    try {
      final result = await localDatasource.report(params);
      return Right(result);
    } catch (e) {
      if (kDebugMode) {
        print(mapExceptionToFailure(e).message);
      }
      return Left(mapExceptionToFailure(e));
    }
  }
}
