import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/generated_apps/presentation/screens/generated_apps_screen.dart';
import 'core/constants/app_colors.dart';
import 'features/core/presentation/screens/desktop_shell.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';
import 'features/projects/presentation/screens/new_project_screen.dart';
import 'features/generation/presentation/screens/prompt_panel_screen.dart';
import 'features/generation/presentation/screens/agent_activity_screen.dart';
import 'features/preview/presentation/screens/preview_screen.dart';

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
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.dark(
            primary: AppColors.primary,
            background: AppColors.background,
            surface: AppColors.surface,
            error: AppColors.error,
          ),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.surface,
            elevation: 0,
            centerTitle: false,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const DesktopShell(child: DashboardScreen()),
          '/new_project': (context) => const DesktopShell(child: NewProjectScreen()),
          '/prompt_panel': (context) => const DesktopShell(child: PromptPanelScreen()),
          '/agent_activity': (context) => const DesktopShell(child: AgentActivityScreen()),
          '/preview': (context) => const DesktopShell(child: PreviewScreen()),
          '/generated_apps': (context) => const GeneratedAppsScreen(), // keep old route mapping just in case
        },
      ),
    );
  }
}
