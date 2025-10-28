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
    final db = await dbService.getAllTasks();
    final DateTime now = DateTime.now();

    // 1. Tentukan Batas Bawah Waktu: Awal hari ini (00:00:00)
    // Ini memastikan semua tugas hari ini (tgl 26) dan masa depan disertakan.
    final DateTime startOfToday = DateTime(now.year, now.month, now.day);
    final int lowerBoundTimestamp = startOfToday.millisecondsSinceEpoch;

    // 2. Konversi Data
    Iterable<TaskModel> data = db.map((e) {
      try {
        return TaskModel.fromMap(e);
      } catch (err) {
        rethrow;
      }
    });

    // 3. Terapkan Filter Tanggal dan Status (Upcoming and Pending)
    data = data.where((task) {
      final taskDate = task.dateOn ?? 0;

      // Tugas harus memiliki tanggal yang valid (> 0)
      if (taskDate == 0) return false;

      // Filter 1: Tanggal >= Awal Hari Ini
      final bool isUpcoming = taskDate >= lowerBoundTimestamp;

      // Filter 2: isStatus = 0 (Pending/Belum Selesai)
      final bool isPending = task.isStatus == 0;

      return isUpcoming && isPending;
    });

    final List<DashboardItemEntity> recentItemsList = data.map((task) {
      // 🛠️ Gunakan fungsi format baru di sini
      final String createdDate = formatTaskCreatedTime(task.createdOn ?? 0);

      // Asumsi nilai untuk logo, title, dan subtitle
      return DashboardItemEntity(
        logo: getLogoAsset(task),
        title: task.title ?? 'No Title',
        subtitle: task.subtitle ?? 'No Subtitle',
        created: createdDate, // Format tanggal dibuat
      );
    }).toList();

    List<TaskModel> pendingUpcomingTasks = data.toList();
    final int pendingCount =
        pendingUpcomingTasks.length; // 🛠️ Dapatkan hitungan

    // 4. Hitung Statistik Dashboard dari hasil filter
    final int pinnedCount = pendingUpcomingTasks
        .where((t) => t.isPinned == 1)
        .length;
    final int favoriteCount = pendingUpcomingTasks
        .where((t) => t.isFavorite == 1)
        .length;
    final int archivedCount = pendingUpcomingTasks
        .where((t) => t.isArchived == 1)
        .length;

    // 5. Buat pesan Greeting
    final String greetingMessage = (pendingCount > 0)
        ? 'Ada $pendingCount catatan yang menunggu untuk kamu selesaikan 🌿'
        : 'Belum ada catatan hari ini, waktu yang pas untuk bersantai ☕️';

    // 6. Kembalikan DashboardEntity
    final name = storage.displayName;
    final result = DashboardEntity(
      name: 'Hi, $name 👋',
      greetings: greetingMessage,
      pinned: pinnedCount,
      favorite: favoriteCount,
      archived: archivedCount,
      total: data.length,
      recentItems: recentItemsList, // Diisi sesuai kebutuhan
    );
    return result;
  }

  // 🛠️ Logika Penentuan Logo
  String getLogoAsset(TaskModel task) {
    if (task.isPinned == 1) {
      return MediaRes.pinned; // Prioritas 1: Pin
    } else if (task.isFavorite == 1) {
      return MediaRes.favorite; // Prioritas 2: Favorite
    } else if (task.isArchived == 1) {
      return MediaRes.archived; // Prioritas 3: Archive
    }
    return MediaRes.totalTask; // Default jika tidak ada status khusus
  }
}
