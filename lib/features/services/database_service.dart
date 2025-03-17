import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/response_model.dart';
import 'package:mitask/features/report/data/models/report_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _dBService = DatabaseService._internal();
  factory DatabaseService() => _dBService;
  DatabaseService._internal();
  final uuid = const Uuid();

  // Membuat ID unik
  String generateUniqueId() {
    return uuid.v4(); // Versi 4 adalah UUID berbasis random
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'mitask_database.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store user
  // and a table to store users.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ms_task(_id TEXT PRIMARY KEY, title TEXT, subtitle TEXT, notes TEXT, is_status TEXT, is_type TEXT, date_on TEXT, created_on TEXT, updated_on TEXT)',
    );
  }

  Future<ResponseModel> createTask(TaskModel dt) async {
    try {
      final db = await _dBService.database;
      dt.id = generateUniqueId();
      // Lanjutkan insert jika data belum ada
      await db.insert('ms_task', dt.toMap());
      return ResponseModel(isSucces: true, message: 'Berhasil');
    } catch (e) {
      return ResponseModel(isSucces: false, message: 'Error: $e');
    }
  }

  Future<List<TaskModel>> getAllTask() async {
    try {
      final db = await _dBService.database;
      final List<Map<String, dynamic>> maps =
          await db.query('ms_task'); // Ambil semua data
      List<TaskModel> result = [];
      for (var e in maps) {
        result.add(
          TaskModel(
            id: e['_id']?.toString() ?? '',
            title: e['title']?.toString() ?? '',
            subtitle: e['subtitle']?.toString() ?? '',
            notes: e['notes']?.toString() ?? '',
            isStatus: e['is_status'] ?? 'false',
            isType: e['is_type']?.toString() ?? '',
            dateOn: DateTime.parse(e['date_on'].toString()),
            createdOn: DateTime.parse(e['created_on'].toString()),
            updatedOn: DateTime.parse(e['updated_on'].toString()),
          ),
        );
      }
      return result;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<TaskModel>> getTasksByDate(String date) async {
    try {
      final db = await _dBService.database;
      List<TaskModel> result = [];
      List<Map<String, dynamic>> res = await db.query(
        'ms_task',
        where: "strftime('%Y-%m-%d', date_on) = ?",
        whereArgs: [date], // Format harus 'YYYY-MM-DD'
      );
      for (var e in res) {
        result.add(
          TaskModel(
            id: e['_id']?.toString() ?? '',
            title: e['title']?.toString() ?? '',
            subtitle: e['subtitle']?.toString() ?? '',
            notes: e['notes']?.toString() ?? '',
            isStatus: e['is_status'] ?? 'false',
            isType: e['is_type']?.toString() ?? '',
            dateOn: DateTime.parse(e['date_on'].toString()),
            createdOn: DateTime.parse(e['created_on'].toString()),
            updatedOn: DateTime.parse(e['updated_on'].toString()),
          ),
        );
      }
      return result;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ResponseModel> updateTaskStatus(
      String taskId, String newStatus) async {
    try {
      final db = await _dBService.database;
      // Data yang akan diperbarui
      Map<String, dynamic> updatedData = {
        'is_status': newStatus,
        'updated_on': DateTime.now().toString(), // Format timestamp
      };

      // Update di database berdasarkan ID
      int count = await db.update(
        'ms_task',
        updatedData,
        where: '_id = ?',
        whereArgs: [taskId],
      );

      if (count > 0) {
        return ResponseModel(isSucces: true, message: 'Update berhasil');
      } else {
        return ResponseModel(isSucces: false, message: 'Task tidak ditemukan');
      }
    } catch (e) {
      return ResponseModel(isSucces: false, message: 'Error: $e');
    }
  }

  Future<ResponseModel> deleteTaskById(String taskId) async {
    try {
      final db = await _dBService.database;

      // Hapus data berdasarkan ID
      int count = await db.delete(
        'ms_task',
        where: '_id = ?',
        whereArgs: [taskId],
      );

      if (count > 0) {
        return ResponseModel(isSucces: true, message: 'Task berhasil dihapus');
      } else {
        return ResponseModel(isSucces: false, message: 'Task tidak ditemukan');
      }
    } catch (e) {
      return ResponseModel(isSucces: false, message: 'Error: $e');
    }
  }

  Future<ResponseModel> updateChangeDateTask(String taskId, String date) async {
    try {
      final db = await _dBService.database;

      // Data yang akan diperbarui
      Map<String, dynamic> updatedData = {
        'date_on': date,
        'updated_on': DateTime.now().toString(), // Format timestamp
      };

      // Update di database berdasarkan ID
      int count = await db.update(
        'ms_task',
        updatedData,
        where: '_id = ?',
        whereArgs: [taskId],
      );

      if (count > 0) {
        return ResponseModel(isSucces: true, message: 'Update berhasil');
      } else {
        return ResponseModel(isSucces: false, message: 'Task tidak ditemukan');
      }
    } catch (e) {
      return ResponseModel(isSucces: false, message: 'Error: $e');
    }
  }

  Future<List<ReportModel>> getFilterAllTask(
      String startDate, String endDate) async {
    try {
      final db = await _dBService.database;

      // 🔹 Query dengan filter tanggal berdasarkan createdOn
      final List<Map<String, dynamic>> maps = await db.query(
        'ms_task',
        where: "strftime('%Y-%m-%d', date_on) BETWEEN ? AND ?",
        whereArgs: [startDate, endDate], // Kirim dalam format 'yyyy-MM-dd'
      );
      List<ReportModel> result = maps.map((e) {
        return ReportModel(
          id: e['_id']?.toString() ?? '',
          title: e['title']?.toString() ?? '',
          subtitle: e['subtitle']?.toString() ?? '',
          notes: e['notes']?.toString() ?? '',
          isStatus: e['is_status'] ?? 'false',
          isType: e['is_type']?.toString() ?? '',
          dateOn: DateTime.parse(e['date_on'].toString()),
          createdOn: DateTime.parse(e['created_on'].toString()),
          updatedOn: DateTime.parse(e['updated_on'].toString()),
        );
      }).toList();

      return result;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<TaskModel>> getExport() async {
    try {
      final db = await _dBService.database;
      final List<Map<String, dynamic>> maps =
          await db.query('ms_task'); // Ambil semua data
      List<TaskModel> result = [];
      for (var e in maps) {
        result.add(
          TaskModel(
            id: e['_id']?.toString() ?? '',
            title: e['title']?.toString() ?? '',
            subtitle: e['subtitle']?.toString() ?? '',
            notes: e['notes']?.toString() ?? '',
            isStatus: e['is_status'] ?? 'false',
            isType: e['is_type']?.toString() ?? '',
            dateOn: DateTime.parse(e['date_on'].toString()),
            createdOn: DateTime.parse(e['created_on'].toString()),
            updatedOn: DateTime.parse(e['updated_on'].toString()),
          ),
        );
      }
      return result;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ResponseModel> updateTask(TaskModel dt) async {
  try {
    final db = await _dBService.database;
    
    // Pastikan id tidak null sebelum update
    if (dt.id == null) {
      return ResponseModel(isSucces: false, message: 'Error: ID tidak boleh null');
    }

    // Update data berdasarkan ID
    int count = await db.update(
      'ms_task',
      dt.toMap(),
      where: '_id = ?',
      whereArgs: [dt.id],
    );

    if (count > 0) {
      return ResponseModel(isSucces: true, message: 'Berhasil memperbarui task');
    } else {
      return ResponseModel(isSucces: false, message: 'Task tidak ditemukan');
    }
  } catch (e) {
    return ResponseModel(isSucces: false, message: 'Error: $e');
  }
}

}
