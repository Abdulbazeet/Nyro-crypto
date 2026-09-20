import 'package:go_router/go_router.dart';
import 'package:nyro_cryto/features/splash_screen/screen/splash_screen.dart';

class AppRoute {
  static final routes = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    ],
  );
}
