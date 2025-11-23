import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/core/utils/app_version.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/features/report/presentation/bloc/report_bloc.dart';
import 'package:mitask/features/task/presentation/bloc/task_bloc.dart';
import 'package:mitask/features/onboarding/splash_screen.dart';
import 'package:mitask/services_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInfo.init();
  await di.init();
  final GetIt getIt = GetIt.instance;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => getIt<DashboardBloc>(),
        ),
        BlocProvider<TaskBloc>(create: (context) => getIt<TaskBloc>()),
        BlocProvider<ReportBloc>(create: (context) => getIt<ReportBloc>()),
        // Tambahkan provider lain jika diperlukan
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins', // Mengatur font default untuk aplikasi
      ),
      title: StringResources.nameApp,
      initialRoute: '/splash',
      // getPages: AppPages.routes,
      // unknownRoute: AppPages.routes.first,
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1)),
          child: child ?? const SizedBox.shrink(),
        );
      },
      routes: {
        '/splash': (context) => const SplashScreen(),
        // Definisikan rute lain di sini jika diperlukan
      },
    );
  }
}
