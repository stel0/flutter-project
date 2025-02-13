import 'package:curso_de_verano/login_screen.dart';
import 'package:curso_de_verano/navigator_bar.dart';
import 'package:curso_de_verano/selfie_screen.dart';
import 'package:curso_de_verano/signup_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = 
    GoRouter(
      initialLocation: LoginScreen.routeName,
      routes:[
        GoRoute(
          path:LoginScreen.routeName,
          builder:(context,state)=>LoginScreen()
        ),
        GoRoute(
          path: SignupScreen.routeName,
          builder: (context, state) => SignupScreen(),
        ),
        GoRoute(
          path: NavigatorBar.routeName,
          builder:(context, state) => NavigatorBar(),
        ),
        GoRoute(
          path: "/selfie",
          builder: (context, state) {
            final name = state.uri.queryParameters['name'];
            final password = state.uri.queryParameters['password'];
            final email = state.uri.queryParameters['email'];
            final phone = state.uri.queryParameters['phone'];

            return SelfieScreen(
              name: name!,
              password: password!,
              email: email!,
              phone: phone!,
            );
          }
        )
      ]
    );
}