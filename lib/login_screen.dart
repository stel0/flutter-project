import 'dart:developer';

import 'package:curso_de_verano/navigator_bar.dart';
import 'package:curso_de_verano/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                hintText: 'Correo',
              ),
              onChanged: (value) {
                email = value;
                log(email);
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true, 
              decoration: InputDecoration(
                hintText: 'Contrasena'
              ),
              onChanged: (value) {
                password = value;
                log(password);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              _login(context,email: email,password: password);
              // Navigate to the home screen
              context.go(NavigatorBar.routeName);
            }, child: Text("Iniciar sesion")),
            
            const SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              context.push(SignupScreen.routeName);
            },child: Text("Registrate"))
          ],
        ),
      )),
    );
  }
  
  void _login(BuildContext context, {required String email,required String password})async {
    try {
      //Iniciamos session con Firebase.
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        log('User signed in successfully: ${userCredential.user!.uid}');
      } else {
        log('User sign in failed');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
