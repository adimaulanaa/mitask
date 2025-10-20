import 'package:get_it/get_it.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:mitask/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:mitask/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mitask/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:mitask/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/features/services/database_service.dart';

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
    () => DashboardLocalDataSourceImpl(storage: sl<StorageProvider>(), dbService: sl<DatabaseService>()),
  );

  //! ---------------- Repository ----------------
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      sl<DashboardRemoteDataSource>(),
      sl<DashboardLocalDataSource>(),
    ),
  );

  //! ---------------- Use Cases ----------------
  sl.registerLazySingleton(
    () => DashboardUseCase(sl<DashboardRepository>()),
  );

  //! ---------------- Bloc ----------------
  sl.registerFactory(() => DashboardBloc(dash: sl<DashboardUseCase>()));
}
