import 'package:flutter/material.dart';
import '../presentation/pages/loading_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';

class AppRouter {
  static const String loading = '/loading';
  static const String home = '/';
  static const String auth = '/auth';
  static const String register = '/register';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loading:
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
