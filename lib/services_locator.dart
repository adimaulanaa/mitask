import 'package:get_it/get_it.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:mitask/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mitask/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:mitask/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/features/report/data/datasources/report_local_datasource.dart';
import 'package:mitask/features/report/data/datasources/report_remote_datasource.dart';
import 'package:mitask/features/report/data/repositories/report_repository_impl.dart';
import 'package:mitask/features/report/domain/repositories/report_repository.dart';
import 'package:mitask/features/report/domain/usecases/all_note_usecase.dart';
import 'package:mitask/features/report/domain/usecases/report_usecase.dart';
import 'package:mitask/features/report/presentation/bloc/report_bloc.dart';
import 'package:mitask/features/services/database_service.dart';
import 'package:mitask/features/task/data/datasources/task_local_datasource.dart';
import 'package:mitask/features/task/data/datasources/task_remote_datasource.dart';
import 'package:mitask/features/task/data/repositories/task_repository_impl.dart';
import 'package:mitask/features/task/domain/repositories/task_repository.dart';
import 'package:mitask/features/task/domain/usecases/checklist_task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/create_task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/task_filter_usecase.dart';
import 'package:mitask/features/task/domain/usecases/task_usecase.dart';
import 'package:mitask/features/task/domain/usecases/update_task_usecase.dart';
import 'package:mitask/features/task/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Storage Provider
  final storageProvider = await StorageProvider.create();
  sl.registerSingleton<StorageProvider>(storageProvider);

  final DatabaseService localDatabase = DatabaseService();
  sl.registerLazySingleton(() => localDatabase);

  //! Dashboard
  //! ---------------- Data Sources ----------------
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(
      storage: sl<StorageProvider>(),
      dbService: sl<DatabaseService>(),
    ),
  );

  //! ---------------- Repository ----------------
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      sl<DashboardRemoteDataSource>(),
      sl<DashboardLocalDataSource>(),
    ),
  );

  //! ---------------- Use Cases ----------------
  sl.registerLazySingleton(() => DashboardUseCase(sl<DashboardRepository>()));

  //! ---------------- Bloc ----------------
  sl.registerFactory(() => DashboardBloc(dash: sl<DashboardUseCase>()));

  //! Task
  //! ---------------- Data Sources ----------------
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(
      storage: sl<StorageProvider>(),
      dbService: sl<DatabaseService>(),
    ),
  );

  //! ---------------- Repository ----------------
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      sl<TaskRemoteDataSource>(),
      sl<TaskLocalDataSource>(),
    ),
  );

  //! ---------------- Use Cases ----------------
  sl.registerLazySingleton(() => TaskUseCase(sl<TaskRepository>()));
  sl.registerLazySingleton(() => CreateTaskUseCase(sl<TaskRepository>()));
  sl.registerLazySingleton(() => TaskFilterUseCase(sl<TaskRepository>()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl<TaskRepository>()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl<TaskRepository>()));
  sl.registerLazySingleton(() => ChecklistTaskUseCase(sl<TaskRepository>()));

  //! ---------------- Bloc ----------------
  sl.registerFactory(
    () => TaskBloc(
      task: sl<TaskUseCase>(),
      create: sl<CreateTaskUseCase>(),
      filter: sl<TaskFilterUseCase>(),
      update: sl<UpdateTaskUseCase>(),
      delete: sl<DeleteTaskUseCase>(),
      checklist: sl<ChecklistTaskUseCase>(),
    ),
  );

  //! Report
  //! ---------------- Data Sources ----------------
  sl.registerLazySingleton<ReportRemoteDataSource>(
    () => ReportRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<ReportLocalDataSource>(
    () => ReportLocalDataSourceImpl(
      storage: sl<StorageProvider>(),
      dbService: sl<DatabaseService>(),
    ),
  );

  //! ---------------- Repository ----------------
  sl.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(
      sl<ReportRemoteDataSource>(),
      sl<ReportLocalDataSource>(),
    ),
  );

  //! ---------------- Use Cases ----------------
  sl.registerLazySingleton(() => ReportUseCase(sl<ReportRepository>()));
  sl.registerLazySingleton(() => AllNotesUseCase(sl<ReportRepository>()));

  //! ---------------- Bloc ----------------
  sl.registerFactory(
    () => ReportBloc(report: sl<ReportUseCase>(), all: sl<AllNotesUseCase>(),),
  );
}
