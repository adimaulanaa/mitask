import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/report/domain/entities/report_entity.dart';
import 'package:mitask/features/report/domain/usecases/params/all_notes_params.dart';
import 'package:mitask/features/report/domain/usecases/params/report_filter_params.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';

abstract class ReportRepository {
  Future<Either<Failure, ReportEntity>> report(ReportFilterParams params);
  Future<Either<Failure, List<TaskEntity>>> allNotes(AllNotesParams params);
}
