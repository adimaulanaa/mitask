// File: lib/features/auth/data/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:mitask/core/error/failures.dart';
import 'package:mitask/features/report/data/models/report_model.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<ReportModel>>> report(String start, String end);
  Future<Either<Failure, String>> export();
}
