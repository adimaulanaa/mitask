import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DashboardLocalSource {
  Future<List<DashboardModel>> dashboard();
}

class DashboardLocalSourceImpl implements DashboardLocalSource {
  final SharedPreferences sharedPreferences;
  final DatabaseService dbService;

  DashboardLocalSourceImpl({
    required this.sharedPreferences,
    required this.dbService,
  });

  @override
  Future<List<DashboardModel>> dashboard() async {
    List<DashboardModel> data = [];
    return data;
  }
}
