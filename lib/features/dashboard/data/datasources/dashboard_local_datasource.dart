import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/core/utils/date_utils.dart';
import 'package:mitask/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:mitask/features/task/data/models/task_model.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardEntity> dash();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final StorageProvider storage;
  final DatabaseService dbService;

  DashboardLocalDataSourceImpl({
    required this.storage,
    required this.dbService,
  });

  @override
  Future<DashboardEntity> dash() async {
    // 1️⃣ Panggil getAllTasks: Sudah disinkronkan untuk hanya mengambil data AKTIF (deletedOn IS NULL OR 0)
    final db = await dbService.getAllTasksNotDeleted();
    final DateTime now = DateTime.now();

    // Awal hari ini (00:00:00)
    final DateTime startOfToday = DateTime(now.year, now.month, now.day);
    final int lowerBoundTimestamp = startOfToday.millisecondsSinceEpoch;

    // 2️⃣ Konversi ke model dengan penanganan error yang aman (PERBAIKAN UTAMA)
    // Jika konversi gagal (data rusak), kembalikan null dan filter (whereType<TaskModel>).
    final Iterable<TaskModel> safeActiveTasks = db
        .map((e) {
          try {
            return TaskModel.fromMap(e);
          } catch (err) {
            return null; // Kembalikan null
          }
        })
        .whereType<
          TaskModel
        >(); // <-- Hanya ambil TaskModel yang valid (bukan null)

    Iterable<TaskModel> data = safeActiveTasks;

    // 3️⃣ Filter tugas hari ini & yang belum selesai
    data = data.where((task) {
      final taskDate = task.dateOn ?? 0;
      if (taskDate == 0) return false;

      final bool isUpcoming = taskDate >= lowerBoundTimestamp;
      final bool isPending = task.isStatus == 0;

      return isUpcoming && isPending;
    });

    final List<TaskModel> pendingUpcomingTasks = data.toList();
    final int pendingCount = pendingUpcomingTasks.length;

    // 4️⃣ Hitung statistik (berdasarkan tugas hari ini yang aktif dan pending)
    final int pinnedCount = pendingUpcomingTasks
        .where((t) => t.isPinned == 1)
        .length;
    final int favoriteCount = pendingUpcomingTasks
        .where((t) => t.isFavorite == 1)
        .length;
    final int archivedCount = pendingUpcomingTasks
        .where((t) => t.isArchived == 1)
        .length;

    // 5️⃣ Ambil semua task AKTIF yang aman untuk cek "bulan ini"
    final int startOfMonth = DateTime(
      now.year,
      now.month,
      1,
    ).millisecondsSinceEpoch;

    // ✅ Menggunakan safeActiveTasks (data yang sudah dikonversi dengan aman)
    final List<TaskModel> monthTasks = safeActiveTasks
        .where((task) => (task.dateOn ?? 0) >= startOfMonth)
        .toList();

    final int monthPendingCount = monthTasks
        .where((t) => t.isStatus == 0)
        .length;

    // 6️⃣ Buat pesan Greeting yang lebih kontekstual
    final String greetingMessage = _buildGreetingMessage(
      todayPending: pendingCount,
      monthPending: monthPendingCount,
    );

    // 7️⃣ Konversi ke DashboardItemEntity untuk recentItems
    final List<DashboardItemEntity> recentItemsList = pendingUpcomingTasks.map((
      task,
    ) {
      final String createdDate = formatTaskCreatedTime(task.createdOn ?? 0);
      return DashboardItemEntity(
        logo: getLogoAsset(task),
        title: task.title ?? 'No Title', // ✅ Safe navigation
        subtitle: task.subtitle ?? 'No Subtitle', // ✅ Safe navigation
        created: createdDate,
      );
    }).toList();

    // 8️⃣ Return hasil akhir
    final name = storage.displayName == '' ? '-' : storage.displayName;
    return DashboardEntity(
      name: 'Hi, $name 👋',
      greetings: greetingMessage,
      pinned: pinnedCount,
      favorite: favoriteCount,
      archived: archivedCount,
      total: data.length, // Total tugas aktif yang akan datang/pending
      recentItems: recentItemsList,
    );
  }

  /// 🔹 Membuat greeting message yang dinamis
  String _buildGreetingMessage({
    required int todayPending,
    required int monthPending,
  }) {
    if (todayPending > 0) {
      return 'Ada $todayPending catatan yang menunggu untuk kamu selesaikan hari ini 🌿';
    } else if (monthPending > 0) {
      return 'Ga ada task hari ini, tapi masih ada $monthPending task yang belum selesai bulan ini 💪';
    } else {
      return 'Belum ada catatan hari ini, waktu yang pas untuk bersantai ☕️';
    }
  }

  // 🛠️ Logika Penentuan Logo
  String getLogoAsset(TaskModel task) {
    if (task.isPinned == 1) {
      return MediaRes.pinned;
    } else if (task.isFavorite == 1) {
      return MediaRes.favorite;
    } else if (task.isArchived == 1) {
      return MediaRes.archived;
    }
    return MediaRes.totalTask;
  }
}
