import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  // Singleton Pattern: hanya satu instance aktif
  static final DatabaseService _dBService = DatabaseService._internal();
  factory DatabaseService() => _dBService;
  DatabaseService._internal();

  // Konstanta Database
  static const String _dbName = 'mitask_database.db';
  static const int _dbVersion = 2;

  // Nama Tabel
  static const String taskTable = 'ms_task';

  // Nama Kolom
  static const String taskId = 'id'; // Dulu '_id'
  static const String taskTitle = 'title'; // Dulu 'taskTitle'
  static const String taskSubtitle = 'subtitle'; // Dulu 'taskSubtitle'
  static const String taskNotes = 'notes'; // Dulu 'taskNotes'
  static const String taskIsStatus = 'isStatus';
  static const String taskStatusName = 'statusName';
  static const String taskIsType = 'type';
  static const String taskIsFavorite = 'isFavorite';
  static const String taskIsArchived = 'isArchived';
  static const String taskPriority = 'priority';
  static const String taskReminderOn = 'reminderOn';
  static const String taskDateOn = 'dateOn';
  static const String taskCreatedOn = 'createdOn';
  static const String taskUpdatedOn = 'updatedOn';
  static const String taskDeletedOn = 'deletedOn';
  static const String taskColorTag = 'colorTag';
  static const String taskIsPinned = 'isPinned';
  static const String taskSyncStatus = 'syncStatus';

  final uuid = const Uuid();

  // Membuat ID unik menggunakan UUID v4
  String generateUniqueId() => uuid.v4();

  // Lazy Loading Database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi Database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      onUpgrade: _onUpgrade,
    );
  }

  // Membuat tabel ketika database baru dibuat
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $taskTable (
        $taskId TEXT PRIMARY KEY,
        $taskTitle TEXT,
        $taskSubtitle TEXT,
        $taskNotes TEXT,
        $taskIsStatus INTEGER DEFAULT 0,
        $taskStatusName TEXT,
        $taskIsType TEXT,
        $taskIsFavorite INTEGER DEFAULT 0,
        $taskIsArchived INTEGER DEFAULT 0,
        $taskPriority INTEGER DEFAULT 0,
        $taskReminderOn INTEGER DEFAULT 0,
        $taskDateOn INTEGER DEFAULT 0,
        $taskCreatedOn INTEGER DEFAULT 0,
        $taskUpdatedOn INTEGER DEFAULT 0,
        $taskDeletedOn INTEGER DEFAULT 0,
        $taskColorTag INTEGER DEFAULT 0,
        $taskIsPinned INTEGER DEFAULT 0,
        $taskSyncStatus INTEGER DEFAULT 0
      );
    ''');
  }

  // Menangani upgrade versi database
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // if (oldVersion < 2) {
    //   await db.execute(
    //     'ALTER TABLE $taskTable ADD COLUMN $taskSyncStatus INTEGER DEFAULT 0',
    //   );
    // }
  }

  // CRUD: INSERT
  Future<int> insertTask(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      taskTable,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // CRUD: GET ALL TASKS
  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await database;
    // taskDeletedOn harus NULL atau 0 untuk dianggap aktif.
    const String whereClause = '$taskDeletedOn IS NULL OR $taskDeletedOn = 0';
    return await db.query(
      taskTable,
      where: whereClause, // 🛑 Tambahkan filter untuk soft delete
      orderBy: '$taskIsPinned DESC, $taskUpdatedOn DESC',
    );
  }

  // CRUD: GET BY ID
  Future<Map<String, dynamic>?> getTaskById(String id) async {
    final db = await database;
    final result = await db.query(
      taskTable,
      where: '$taskId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // CRUD: UPDATE
  Future<int> updateTask(String id, Map<String, dynamic> data) async {
    final db = await database;
    data[taskUpdatedOn] = DateTime.now().millisecondsSinceEpoch;
    return await db.update(
      taskTable,
      data,
      where: '$taskId = ?',
      whereArgs: [id],
    );
  }

  // CRUD: DELETE (Soft Delete)
  Future<int> deleteTask(String id) async {
    final db = await database;
    return await db.update(
      taskTable,
      {taskDeletedOn: DateTime.now().millisecondsSinceEpoch},
      where: '$taskId = ?',
      whereArgs: [id],
    );
  }

  // Hapus permanen (Hard Delete)
  Future<int> hardDeleteTask(String id) async {
    final db = await database;
    return await db.delete(taskTable, where: '$taskId = ?', whereArgs: [id]);
  }

  Future<int> checklistTask(String id, String status, int isStatus) async {
    final db = await database;
    return await db.update(
      taskTable,
      {
        taskUpdatedOn: DateTime.now().millisecondsSinceEpoch,
        taskIsStatus: isStatus,
        taskStatusName: status,
      },
      where: '$taskId = ?',
      whereArgs: [id],
    );
  }

  // Helper: Toggle Pin/Favorite/Archive
  Future<void> toggleFavorite(String id, bool isFavorite) async {
    final db = await database;
    await db.update(
      taskTable,
      {taskIsFavorite: isFavorite ? 1 : 0},
      where: '$taskId = ?',
      whereArgs: [id],
    );
  }

  Future<void> togglePinned(String id, bool isPinned) async {
    final db = await database;
    await db.update(
      taskTable,
      {taskIsPinned: isPinned ? 1 : 0},
      where: '$taskId = ?',
      whereArgs: [id],
    );
  }

  Future<void> toggleArchived(String id, bool isArchived) async {
    final db = await database;
    await db.update(
      taskTable,
      {taskIsArchived: isArchived ? 1 : 0},
      where: '$taskId = ?',
      whereArgs: [id],
    );
  }

  // Close Database
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null && db.isOpen) {
      await db.close();
    }
  }
}
