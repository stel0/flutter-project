import 'package:curso_de_verano/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = 
    GoRouter(
      initialLocation: LoginScreen.routeName,
      routes:[
        GoRoute(
          path:LoginScreen.routeName,
          builder:(context,state)=>LoginScreen()
        )
      ]
    );
}