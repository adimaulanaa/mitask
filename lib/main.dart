import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mitask/core/config/config_resources.dart';
import 'package:mitask/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mitask/onboarding.dart';
import 'package:mitask/services_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  await di.init();
  final GetIt getIt = GetIt.instance;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => getIt<DashboardBloc>(),
        ),
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
      initialRoute: '/onboarding',
      // getPages: AppPages.routes,
      // unknownRoute: AppPages.routes.first,
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      routes: {
        '/onboarding': (context) => const Onboarding(),
        // Definisikan rute lain di sini jika diperlukan
      },
    );
  }
}
