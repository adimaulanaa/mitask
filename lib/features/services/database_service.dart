import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  // Singleton Pattern: Memastikan hanya ada satu instance dari DatabaseService
  static final DatabaseService _dBService = DatabaseService._internal();
  factory DatabaseService() => _dBService;
  DatabaseService._internal();

  // Konstan untuk Database dan Nama Tabel/Kolom
  static const String _dbName = 'mitask_database.db';
  static const int _dbVersion = 1;

  static const String taskTable = 'ms_task';
  // Nama Kolom
  static const String taskId = '_id';
  static const String taskTitle = 'title';
  static const String taskSubtitle = 'subtitle';
  static const String taskNotes = 'notes';
  static const String taskIsStatus = 'is_status'; // INTEGER: 0=false, 1=true
  static const String taskIsType = 'is_type';
  static const String taskDateOn = 'date_on';     // INTEGER: Unix Timestamp (milidetik)
  static const String taskCreatedOn = 'created_on'; // INTEGER: Unix Timestamp
  static const String taskUpdatedOn = 'updated_on'; // INTEGER: Unix Timestamp

  final uuid = const Uuid();

  // Membuat ID unik menggunakan UUID v4
  String generateUniqueId() {
    return uuid.v4(); 
  }

  // Lazy Loading untuk Database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // --- INISIALISASI DATABASE ---
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: _dbVersion,
      // Mengaktifkan Foreign Keys (jika nanti Anda butuh relasi)
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // --- MEMBUAT TABEL KETIKA DATABASE BARU DIBUAT ---
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $taskTable (
        $taskId TEXT PRIMARY KEY,
        $taskTitle TEXT,
        $taskSubtitle TEXT,
        $taskNotes TEXT,
        $taskIsStatus INTEGER DEFAULT 0,  
        $taskIsType TEXT,
        $taskDateOn INTEGER,
        $taskCreatedOn INTEGER,
        $taskUpdatedOn INTEGER
      )
      ''',
    );
    // Tambahkan tabel lain di sini jika diperlukan di masa mendatang.
  }

  // --- CONTOH FUNGSI CRUD (INSERT) ---
  Future<int> insertTask(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      taskTable,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}