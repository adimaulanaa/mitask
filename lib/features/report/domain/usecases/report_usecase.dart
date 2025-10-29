import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/report/domain/entities/report_entity.dart';
import 'package:mitask/features/report/domain/repositories/report_repository.dart';
import 'package:mitask/features/report/domain/usecases/params/report_filter_params.dart';

class ReportUseCase {
  final ReportRepository repository;

  ReportUseCase(this.repository);

  Future<Either<Failure, ReportEntity>> call(ReportFilterParams params) async {
    // Panggil fungsi login dari Repository
    return await repository.report(params);
  }
}