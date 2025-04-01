import 'package:flutter/material.dart';
import '../presentation/pages/loading_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AppRouter {
  static const String loading = '/loading';
  static const String home = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loading:
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
