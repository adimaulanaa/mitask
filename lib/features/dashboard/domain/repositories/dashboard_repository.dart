import 'package:dartz/dartz.dart';
import 'package:mitask/core/network/hendler_failure.dart';
import 'package:mitask/features/dashboard/data/models/date_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<DateModel>>> dash();
}
