import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:mitask/features/task/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> get();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final StorageProvider storage;
  final DatabaseService dbService;

  TaskLocalDataSourceImpl({required this.storage, required this.dbService});

  @override
  Future<List<TaskModel>> get() async {
    await Future.delayed(Duration(seconds: 3));
    final db = await dbService.getAllTasks();
    final result = db.map((e) => TaskModel.fromMap(e)).toList();
    return result;
  }
}
