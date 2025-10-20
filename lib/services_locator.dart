import 'package:get_it/get_it.dart';
import 'package:mitask/core/storage/storage_provider.dart';
import 'package:mitask/features/services/database_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Storage Provider
  final storageProvider = await StorageProvider.create();
  sl.registerSingleton<StorageProvider>(storageProvider);

  final DatabaseService localDatabase = DatabaseService();
  sl.registerLazySingleton(() => localDatabase);
}
