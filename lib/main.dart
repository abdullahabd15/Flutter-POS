import 'package:auth/presentation/cubit/login/login_cubit.dart';
import 'package:auth/presentation/ui/login/login_screen.dart';
import 'package:common/extension/extension.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:dependencies/google_fonts/google_fonts.dart';
import 'package:dependencies/hydrated_bloc/hydrated_bloc.dart';
import 'package:dependencies/path_provider/path_provider.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/cubit/main_cubit.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:flutter_pos/di/di.dart';
import 'package:flutter_pos/ui/main_container_screen.dart';
import 'package:resources/enum/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection().init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        return BlocProvider(
          create: (_) => MainCubit(isLoggedIn: snapshot.data == true)
            ..checkAndSyncLoginStatus(),
          child: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return MaterialApp.router(
                theme: _themeData,
                routerConfig: _router(state),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      },
    );
  }

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getToken();
    return token != null && token.isNotEmpty ? true : false;
  }

  GoRouter _router(MainState state) => GoRouter(
        initialLocation: state.currentRoute.route,
        routes: [
          GoRoute(
            path: Routes.login.route,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => LoginCubit(loginUseCase: sl()),
                child: LoginScreen(
                  onLoginSuccess: () {
                    context
                        .read<MainCubit>()
                        .setCurrentRoute(Routes.home.route);
                    GoRouter.of(context).go(Routes.home.route);
                  },
                ),
              ),
            ),
          ),
          GoRoute(
            path: Routes.home.route,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MainContainerScreen(),
            ),
          ),
        ],
      );

  final ThemeData _themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.urbanist(),
      bodyLarge: GoogleFonts.urbanist(),
      bodySmall: GoogleFonts.urbanist(),
      displayMedium: GoogleFonts.urbanist(),
      displayLarge: GoogleFonts.urbanist(),
      displaySmall: GoogleFonts.urbanist(),
      headlineMedium: GoogleFonts.urbanist(),
      headlineLarge: GoogleFonts.urbanist(),
      headlineSmall: GoogleFonts.urbanist(),
      titleMedium: GoogleFonts.urbanist(),
      titleLarge: GoogleFonts.urbanist(),
      titleSmall: GoogleFonts.urbanist(),
      labelMedium: GoogleFonts.urbanist(),
      labelLarge: GoogleFonts.urbanist(),
      labelSmall: GoogleFonts.urbanist(),
    ),
  );
}
