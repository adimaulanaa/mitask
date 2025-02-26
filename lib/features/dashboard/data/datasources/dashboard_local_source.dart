import 'package:mitask/features/dashboard/data/models/dashboard_model.dart';
import 'package:mitask/features/dashboard/data/models/model.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

abstract class DashboardLocalSource {
  Future<List<DateModel>> dashboard();
  Future<List<TaskModel>> taskByDate(String date);
}

class DashboardLocalSourceImpl implements DashboardLocalSource {
  final SharedPreferences sharedPreferences;
  final DatabaseService dbService;

  DashboardLocalSourceImpl({
    required this.sharedPreferences,
    required this.dbService,
  });

  @override
  Future<List<DateModel>> dashboard() async {
    List<DateModel> data = [];
    DateTime now = DateTime.now(); // Dapatkan tanggal sekarang
    // Hitung jumlah hari dalam bulan ini
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<TaskModel> allTask = await dbService.getAllTask();

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(now.year, now.month, day);
      String dayName = DateFormat('EEE').format(currentDate);

      // Filter data dari database yang memiliki created_on sesuai currentDate
      var tasksForTheDay = allTask.where((task) {
        DateTime createdOn = DateTime.parse(task.createdOn.toString());
        return createdOn.year == currentDate.year &&
            createdOn.month == currentDate.month &&
            createdOn.day == currentDate.day;
      }).toList();

      // Hitung jumlah task
      int taskToday = tasksForTheDay.length;
      int taskFinished =
          tasksForTheDay.where((task) => task.isStatus == 'true').length;
      int taskPending = taskToday - taskFinished;

      data.add(
        DateModel(
          day: dayName, // Nama hari (Mon, Tue, dst.)
          date: "${currentDate.day}", // Hari dalam angka
          dateTime: currentDate, // Tanggal lengkap
          taskToday: "$taskToday", // Total task pada hari tersebut
          taskFinish: "$taskFinished", // Task yang selesai
          taskPendding: "$taskPending", // Task yang masih pending
        ),
      );
    }

    return data;
  }
  
  @override
  Future<List<TaskModel>> taskByDate(String date) async {
    List<TaskModel> result = await dbService.getTasksByDate(date);
    return result;
  }
}
