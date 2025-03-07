import 'package:dartz/dartz.dart';
import 'package:mitask/core/error/failures.dart';
import 'package:mitask/features/report/data/datasources/report_local_source.dart';
import 'package:mitask/features/report/data/models/report_model.dart';
import 'package:mitask/features/report/data/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportLocalSource dataLocalSource;

  ReportRepositoryImpl({required this.dataLocalSource});

  @override
  Future<Either<Failure, List<ReportModel>>> report(String start, String end) async {
    try {
      final result = await dataLocalSource.report(start, end);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> export() async {
    try {
      final result = await dataLocalSource.export();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}
