import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/features/dashboard/data/models/date_model.dart';
import 'package:mitask/features/services/database_service.dart';

abstract class DashboardLocalDataSource {
  Future<List<DateModel>> dash();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final StorageProvider storage;
  final DatabaseService dbService;

  DashboardLocalDataSourceImpl({
    required this.storage,
    required this.dbService,
  });

  @override
  Future<List<DateModel>> dash() async {
    return [];
  }
}
