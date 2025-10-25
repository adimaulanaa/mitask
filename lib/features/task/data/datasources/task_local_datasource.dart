import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:mitask/features/task/data/models/task_model.dart';
import 'package:mitask/features/task/domain/usecases/params/create_task_params.dart';
import 'package:uuid/uuid.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> get();
  Future<String> create(CreateTaskParams params);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final StorageProvider storage;
  final DatabaseService dbService;

  TaskLocalDataSourceImpl({required this.storage, required this.dbService});

  @override
  Future<List<TaskModel>> get() async {
    await Future.delayed(Duration(seconds: 1));
    final db = await dbService.getAllTasks();
    final result = db.map((e) {
      try {
        return TaskModel.fromMap(e);
      } catch (err) {
        rethrow;
      }
    }).toList();
    return result;
  }

  @override
  Future<String> create(CreateTaskParams params) async {
    final db = await dbService.database;
    await Future.delayed(Duration(seconds: 1));
    // 1. Dapatkan data dasar dari params (yang menggunakan key pendek: title, subtitle, dll.)
    final data = params.toMap();
    // 2. Generate UUID dan tambahkan ke Map menggunakan KEY PENDEK 'id'
    final String uniqueId = const Uuid().v4();
    data['id'] = uniqueId; // 🛠️ PASTIKAN KEY-nya ADALAH 'id'
    // 3. Hapus null
    data.removeWhere((key, value) => value == null);
    // 4. Insert data
    // Query yang dihasilkan akan: INSERT INTO ms_task (title, subtitle, ..., id)
    await db.insert('ms_task', data);
    return 'Data berhasil tersimpan';
  }
}
