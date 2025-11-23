import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/report/domain/repositories/report_repository.dart';
import 'package:mitask/features/report/domain/usecases/params/all_notes_params.dart';
import 'package:mitask/features/task/domain/entities/task_entity.dart';

class AllNotesUseCase {
  final ReportRepository repository;

  AllNotesUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call(AllNotesParams params) async {
    // Panggil fungsi login dari Repository
    return await repository.allNotes(params);
  }
}