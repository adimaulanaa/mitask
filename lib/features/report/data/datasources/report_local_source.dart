import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mitask/features/report/data/models/report_model.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ReportLocalSource {
  Future<List<ReportModel>> report(String startDate, String endDate);
  Future<String> export();
}

class ReportLocalSourceImpl implements ReportLocalSource {
  final SharedPreferences sharedPreferences;
  final DatabaseService dbService;

  ReportLocalSourceImpl({
    required this.sharedPreferences,
    required this.dbService,
  });

  @override
  Future<List<ReportModel>> report(String start, String end) async {
    DateTime today = DateTime.now();
    DateTime startDate = today;
    DateTime endDate = today;
    if (start != '' || end != '') {
      startDate = DateFormat('yyyy-M-d').parse(start);
      endDate = DateFormat('yyyy-M-d').parse(end);
    }

    // Convert DateTime ke String agar sesuai format SQLite
    String formattedStart = DateFormat('yyyy-MM-dd').format(startDate);
    String formattedEnd = DateFormat('yyyy-MM-dd').format(endDate);

    List<ReportModel> allTask =
        await dbService.getFilterAllTask(formattedStart, formattedEnd);
    return allTask;
  }

  @override
  Future<String> export() async {
    try {
      // 🔹 Minta izin
      if (!await Permission.storage.request().isGranted &&
          !await Permission.manageExternalStorage.request().isGranted) {
        return '❌ Izin penyimpanan ditolak!';
      }

      // 🔹 Cari lokasi penyimpanan aplikasi
      Directory? appDir = await getExternalStorageDirectory();
      if (appDir == null) {
        return '❌ Tidak dapat mengakses direktori penyimpanan.';
      }

      // 🔹 Simpan sementara di folder aplikasi
      String tempFilePath = '${appDir.path}/export_data.json';
      File tempFile = File(tempFilePath);
      String jsonData = jsonEncode({"contoh": "data"});
      await tempFile.writeAsString(jsonData);

      // 🔹 Pastikan folder Download ada
      Directory downloadsDir = Directory('/storage/emulated/0/Download');
      if (!downloadsDir.existsSync()) {
        return '❌ Folder Download tidak ditemukan!';
      }

      // 🔹 Pindahkan file ke Downloads
      String finalPath = '${downloadsDir.path}/export_data.json';
      await tempFile.copy(finalPath);

      return '✅ Berhasil menyimpan file di: $finalPath';
    } catch (e) {
      return '❌ Error: $e';
    }
  }
}
