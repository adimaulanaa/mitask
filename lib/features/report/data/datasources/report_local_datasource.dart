import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/core/utils/date_utils.dart';
import 'package:mitask/features/report/domain/entities/report_entity.dart';
import 'package:mitask/features/report/domain/usecases/params/report_filter_params.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:mitask/features/task/data/models/task_model.dart';

abstract class ReportLocalDataSource {
  Future<ReportEntity> report(ReportFilterParams params);
}

class ReportLocalDataSourceImpl implements ReportLocalDataSource {
  final StorageProvider storage;
  final DatabaseService dbService;

  ReportLocalDataSourceImpl({required this.storage, required this.dbService});

  @override
  Future<ReportEntity> report(ReportFilterParams params) async {
    // Memanggil getAllTasks yang sudah difilter untuk hanya mendapatkan data AKTIF
    final db = await dbService.getAllTasksNotDeleted();

    int pinnedCount = 0;
    int favoriteCount = 0;
    int penddingCount = 0;
    int archivedCount = 0;
    int complatedCount = 0;
    int totalCount = 0;

    // 1️⃣ Konversi data dengan PENANGANAN ERROR (mengganti rethrow)
    // Gunakan whereType<TaskModel>() untuk membuang hasil null dari try/catch
    Iterable<TaskModel> data = db.map((e) {
      try {
        return TaskModel.fromMap(e);
      } catch (err) {
        // Log error di sini jika perlu
        return null; // Kembalikan null untuk data yang rusak
      }
    }).whereType<TaskModel>(); // <-- Hanya mengambil objek TaskModel yang valid

    List<TaskModel> allTasks = data.toList();

    // 2️⃣ Tentukan batas waktu filter
    final DateTime now = DateTime.now();
    DateTime? startDate;

    switch (params.periodType) {
      case '1w': // 1 minggu terakhir
        startDate = now.subtract(const Duration(days: 7));
        break;
      case '2w': // 2 minggu terakhir
        startDate = now.subtract(const Duration(days: 14));
        break;
      case '1m': // 1 bulan terakhir
        startDate = now.subtract(const Duration(days: 30));
        break;
      default:
        startDate = null; // Semua data
    }

    // 3️⃣ Filter task berdasarkan tanggal dateOn (Menggunakan safe navigation)
    List<TaskModel> filteredTasks = allTasks.where((task) {
      if (startDate == null) return true; // Semua data
      
      final taskDateTimestamp = task.dateOn ?? 0; // ✅ Menggunakan ?? 0
      if (taskDateTimestamp == 0) return false;

      final createdDate = DateTime.fromMillisecondsSinceEpoch(taskDateTimestamp);
      return createdDate.isAfter(startDate);
    }).toList();

    // 4️⃣ Hitung statistik
    pinnedCount = filteredTasks.where((t) => t.isPinned == 1).length;
    favoriteCount = filteredTasks.where((t) => t.isFavorite == 1).length;
    archivedCount = filteredTasks.where((t) => t.isArchived == 1).length;
    penddingCount = filteredTasks.where((t) => t.isStatus == 0).length;
    complatedCount = filteredTasks.where((t) => t.isStatus == 1).length;
    totalCount = filteredTasks.length;

    // 5️⃣ Ambil prioritas tinggi untuk recentItems
    final List<TaskModel> priorityTask = filteredTasks
        .where((e) => (e.priority) == 2) // ✅ Menggunakan ?? 0 untuk priority
        .toList();

    final List<ReportItemEntity> recentItemsList = priorityTask.map((task) {
      final String createdDate = formatTaskCreatedTime(task.dateOn ?? 0);
      return ReportItemEntity(
        id: task.id,
        title: task.title ?? 'No Title', 
        subtitle: task.subtitle ?? 'No Subtitle',
        created: createdDate,
      );
    }).toList();
    final productivity = calculateProductivity(filteredTasks);

    // 6️⃣ Return hasil akhir
    final result = ReportEntity(
      pinned: pinnedCount,
      favorite: favoriteCount,
      pending: penddingCount,
      archived: archivedCount,
      complated: complatedCount,
      total: totalCount,
      recentItems: recentItemsList,
      productivity: productivity,
    );
    return result;
  }

  /// Hitung productivity per hari dari list TaskModel
  ProductivityEntity calculateProductivity(List<TaskModel> tasks) {
    // 1️⃣ Buat map default untuk semua hari
    final Map<String, int> totalMap = {
      "mon": 0, "tue": 0, "wed": 0, "thu": 0, "fri": 0, "sat": 0, "sun": 0,
    };
    final Map<String, int> completedMap = {
      "mon": 0, "tue": 0, "wed": 0, "thu": 0, "fri": 0, "sat": 0, "sun": 0,
    };

    for (final task in tasks) {
      final taskDateTimestamp = task.dateOn ?? 0; // ✅ Menggunakan ?? 0
      if (taskDateTimestamp == 0) continue; // Lewati task tanpa tanggal

      final date = DateTime.fromMillisecondsSinceEpoch(taskDateTimestamp);
      final dayKey = _getDayKey(date);

      totalMap[dayKey] = (totalMap[dayKey] ?? 0) + 1;
      if (task.isStatus == 1) {
        completedMap[dayKey] = (completedMap[dayKey] ?? 0) + 1;
      }
    }

    final Map<String, double> dailySummary = {};
    totalMap.forEach((day, total) {
      final completed = completedMap[day] ?? 0;
      dailySummary[day] = total == 0 ? 0.0 : completed / total;
    });

    return ProductivityEntity.fromDailySummary(dailySummary);
  }

  /// Helper: dapatkan day key lowercase (mon, tue, etc.)
  String _getDayKey(DateTime date) {
    const days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
    return days[date.weekday - 1];
  }
}