import 'package:get_it/get_it.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_local_source.dart';
import 'package:mitask/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:mitask/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/features/report/data/datasources/report_local_source.dart';
import 'package:mitask/features/report/data/repositories/report_repository.dart';
import 'package:mitask/features/report/data/repositories/report_repository_impl.dart';
import 'package:mitask/features/report/presentation/bloc/report_bloc.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final DatabaseService localDatabase = DatabaseService();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => localDatabase);

  //! Core
  // sl.registerLazySingleton<Dio>(() => createDio());

  //! Dashboard
  sl.registerLazySingleton<DashboardLocalSource>(
    () => DashboardLocalSourceImpl(
      sharedPreferences: sl<SharedPreferences>(),
      dbService: sl<DatabaseService>(),
    ),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(dataLocalSource: sl<DashboardLocalSource>()),
  );
  sl.registerFactory(
      () => DashboardBloc(dashboardRepo: sl<DashboardRepository>()));

  //! Report
  sl.registerLazySingleton<ReportLocalSource>(
    () => ReportLocalSourceImpl(
      sharedPreferences: sl<SharedPreferences>(),
      dbService: sl<DatabaseService>(),
    ),
  );
  sl.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(dataLocalSource: sl<ReportLocalSource>()),
  );
  sl.registerFactory(
      () => ReportBloc(reportRepo: sl<ReportRepository>()));
}
