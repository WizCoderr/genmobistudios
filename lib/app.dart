import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/generated_apps/presentation/screens/generated_apps_screen.dart';
import 'core/constants/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'GenMobi Studio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            background: AppColors.background,
            surface: AppColors.surface,
          ),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/generated_apps': (context) => const GeneratedAppsScreen(),
        },
      ),
    );
  }
}
