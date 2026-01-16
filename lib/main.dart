import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krishipal/core/api/api_client.dart';
import 'package:krishipal/features/auth/presentation/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:krishipal/app/theme/app_theme.dart';
import 'package:krishipal/core/services/hive/hive_service.dart';
import 'package:krishipal/features/auth/presentation/state/auth_state.dart';
import 'package:krishipal/features/auth/presentation/pages/login_page.dart'; // Add login page import
import 'package:krishipal/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:krishipal/features/splash/presentation/pages/splash_page.dart';
import 'package:krishipal/core/services/storage/user_session.dart';
import 'package:krishipal/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:krishipal/features/auth/data/datasources/remote/auth_remote_datasource.dart';

/// Define a SharedPreferences provider
final sharedPreferenceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in main.dart');
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize Hive
  final hiveService = HiveService();
  await hiveService.init();

  // Initialize UserSessionService
  final userSessionService = UserSessionService(
    sharedPreferences: sharedPreferences,
  );

  // Initialize ApiClient
  final apiClient = ApiClient();

  runApp(
    ProviderScope(
      overrides: [
        // Override SharedPreferences
        sharedPreferenceProvider.overrideWithValue(sharedPreferences),

        // Override UserSessionService
        userSessionServiceProvider.overrideWithValue(userSessionService),

        // Override ApiClient
        apiClientProvider.overrideWithValue(apiClient),

        // Override Local Datasource
        authLocalDataSourceProvider.overrideWithValue(
          AuthLocalDatasource(userSessionService: userSessionService),
        ),

        // Override Remote Datasource
        authRemoteDatasourceProvider.overrideWithValue(
          AuthRemoteDatasource(
            apiClient: apiClient,
            userSessionService: userSessionService,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize auth state when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthState();
    });
  }

  void _checkAuthState() async {
    // This method can be used to check authentication state on app start
    // For example, you could check if user is logged in via shared preferences
    final isLoggedIn = ref.read(userSessionServiceProvider).isLoggedIn();

    if (!isLoggedIn) {
      // If not logged in, ensure auth state is unauthenticated
      ref.read(authViewModelProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krishipal',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AppWrapper(), // Use a wrapper widget instead
    );
  }
}

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    // Show loading while checking auth state
    if (authState.status == AuthStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Route based on auth status
    switch (authState.status) {
      case AuthStatus.authenticated:
        return const DashboardPage();
      case AuthStatus.unauthenticated:
      case AuthStatus.initial:
      case AuthStatus.registered:
      case AuthStatus.error:
      default:
        // Instead of SplashPage, go directly to LoginPage
        // Or keep SplashPage if it has animation/initialization logic
        return const LoginPage(); // Changed from SplashPage to LoginPage
    }
  }
}
