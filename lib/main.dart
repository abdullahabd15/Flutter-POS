import 'package:auth/presentation/ui/forgot_password/forgot_password_screen.dart';
import 'package:auth/presentation/ui/login/login_screen.dart';
import 'package:auth/presentation/ui/register/register_screen.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:dependencies/google_fonts/google_fonts.dart';
import 'package:dependencies/hydrated_bloc/hydrated_bloc.dart';
import 'package:dependencies/path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/cubit/main_cubit.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:flutter_pos/di/di.dart';
import 'package:flutter_pos/ui/main_container_screen.dart';
import 'package:home/presentation/ui/home/home_screen.dart';
import 'package:order/presentation/ui/order_history/transactions_history_screen.dart';
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
    return BlocProvider(
      create: (_) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
        return MaterialApp.router(
          theme: _themeData,
          routerConfig: _router(state),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }

  GoRouter _router(MainState state) => GoRouter(
        initialLocation: state.currentRoute.route,
        routes: [
          GoRoute(
            path: Routes.login.route,
            pageBuilder: (context, state) => NoTransitionPage(
              child: LoginScreen(),
            ),
          ),
          GoRoute(
            path: Routes.register.route,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: RegisterScreen(),
            ),
          ),
          GoRoute(
            path: Routes.forgotPassword.route,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ForgotPasswordScreen(),
            ),
          ),
          GoRoute(
            path: Routes.home.route,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MainContainerScreen(
                child: HomeScreen(),
              ),
            ),
          ),
          GoRoute(
            path: Routes.transactions.route,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MainContainerScreen(
                child: TransactionsHistoryScreen(),
              ),
            ),
          ),
          GoRoute(
            path: Routes.report.route,
            pageBuilder: (context, state) => NoTransitionPage(
              child: MainContainerScreen(
                child: Container(),
              ),
            ),
          ),
        ],
      );

  final ThemeData _themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
