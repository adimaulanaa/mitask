import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:mitask/features/task/data/models/task_model.dart';
import 'package:mitask/features/task/domain/usecases/params/create_task_params.dart';
import 'package:mitask/features/task/domain/usecases/params/task_filter_params.dart';
import 'package:uuid/uuid.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> get();
  Future<String> create(CreateTaskParams params);
  Future<List<TaskModel>> filter(TaskFilterParams params);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final StorageProvider storage;
  final DatabaseService dbService;

  TaskLocalDataSourceImpl({required this.storage, required this.dbService});

  @override
  Future<List<TaskModel>> get() async {
    await Future.delayed(Duration(seconds: 1));
    final db = await dbService.getAllTasks();

    // 1. Hitung Batas Bawah Waktu
    final DateTime now = DateTime.now();
    // Tanggal 30 hari yang lalu (00:00:00 di hari itu)
    final DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));

    // Konversi ke timestamp untuk perbandingan (Unix Epoch)
    final int lowerBoundTimestamp = thirtyDaysAgo.millisecondsSinceEpoch;

    // 2. Konversi dan Filter Data
    Iterable<TaskModel> result = db.map((e) {
      try {
        return TaskModel.fromMap(e);
      } catch (err) {
        rethrow;
      }
    });

    // 3. Terapkan Filter
    result = result.where((task) {
      final taskDate = task.dateOn ?? 0;

      // Tugas harus memiliki tanggal yang valid (> 0)
      if (taskDate == 0) return false;

      // Tugas harus lebih besar atau sama dengan timestamp 30 hari yang lalu
      // Ini memastikan hanya tugas dalam 30 hari terakhir yang lolos.
      return taskDate >= lowerBoundTimestamp;
    });

    // 4. Urutkan dari Terbaru ke Terlama (Opsional, tapi disarankan untuk "Terbaru")
    List<TaskModel> finalResult = result.toList();

    finalResult.sort((a, b) {
      final aDate = a.dateOn ?? 0;
      final bDate = b.dateOn ?? 0;
      // Urutan Descending (Terbaru di atas)
      return bDate.compareTo(aDate);
    });

    return finalResult;
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

  @override
  Future<List<TaskModel>> filter(TaskFilterParams params) async {
    // 1. Ambil semua data (Asumsi: dbService.getAllTasks() mengambil data mentah)
    final db = await dbService.getAllTasks();

    // Konversi ke TaskModel dan simpan sebagai Iterable untuk filtering
    Iterable<TaskModel> result = db.map((e) {
      try {
        return TaskModel.fromMap(e);
      } catch (err) {
        // Logging error mapping
        rethrow;
      }
    });

    // --- 2. Terapkan Filter Pencarian Teks ---
    if (params.query != null && params.query!.isNotEmpty) {
      final query = params.query!.toLowerCase();
      result = result.where((task) {
        final title = task.title?.toLowerCase() ?? '';
        final subtitle = task.subtitle?.toLowerCase() ?? '';
        return title.contains(query) || subtitle.contains(query);
      });
    }

    // --- 3. Terapkan Filter Status (OR Sejati) ---
    if (params.isPin || params.isFav || params.isArch) {
      result = result.where((task) {
        bool matchPin = params.isPin && task.isPinned == 1;
        bool matchFav = params.isFav && task.isFavorite == 1;
        bool matchArch = params.isArch && task.isArchived == 1;
        // Lolos jika memenuhi setidaknya SATU kriteria yang aktif
        return matchPin || matchFav || matchArch;
      });
    }

    // --- 4. Terapkan Filter Tanggal ---
    if (params.startDate != null || params.endDate != null) {
      // Ambil timestamp awal (00:00:00)
      final int startTimestamp = params.startDate?.millisecondsSinceEpoch ?? 0;

      // Ambil timestamp akhir (23:59:59.999)
      final int endTimestamp =
          params.endDate
              ?.add(const Duration(days: 1) - const Duration(milliseconds: 1))
              .millisecondsSinceEpoch ??
          (DateTime(3000).millisecondsSinceEpoch);

      result = result.where((task) {
        final taskDate = task.dateOn;
        // Hanya lolos jika taskDate berada dalam rentang
        if (taskDate == null || taskDate == 0) return false;

        final bool isAfterStart = taskDate >= startTimestamp;
        final bool isBeforeEnd = taskDate <= endTimestamp;

        return isAfterStart && isBeforeEnd;
      });
    }

    // --- 5. Konversi ke List dan Lakukan Sorting ---
    List<TaskModel> finalResult = result.toList();

    // Sortir: Mengurutkan dari Terbaru ke Terlama (Descending)
    // Nilai dateOn yang lebih besar (lebih baru) harus diletakkan sebelum nilai yang lebih kecil.
    finalResult.sort((a, b) {
      final aDate = a.dateOn ?? 0;
      final bDate = b.dateOn ?? 0;

      // b.compareTo(a) menghasilkan urutan DESCENDING (Terbaru ke Terlama)
      return bDate.compareTo(aDate);
    });

    // 6. Kembalikan hasil akhir
    return finalResult;
  }
}
