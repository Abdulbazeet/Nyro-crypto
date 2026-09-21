import 'package:go_router/go_router.dart';
import 'package:nyro_cryto/features/auth_screens/screen/otp_screen.dart';
import 'package:nyro_cryto/features/auth_screens/screen/sign_in.dart';
import 'package:nyro_cryto/features/auth_screens/screen/sign_up.dart';
import 'package:nyro_cryto/features/main-screen/screen/main_screen.dart';
import 'package:nyro_cryto/features/splash_screen/screen/splash_screen.dart';

class AppRoute {
  static final routes = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
      GoRoute(path: '/sign_up', builder: (context, state) => const SignUp()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpScreen()),
      GoRoute(path: '/sign_in', builder: (context, state) => const SignIn()),
    ],
  );
}
