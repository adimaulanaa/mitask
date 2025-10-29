import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/report/domain/entities/report_entity.dart';
import 'package:mitask/features/report/domain/usecases/params/report_filter_params.dart';

abstract class ReportRepository {
  Future<Either<Failure, ReportEntity>> report(ReportFilterParams params);
}
