import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Formulario de registro :)"
              ),
              
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre y Apellido',
                  hintText: 'Ejemplo : Francisco Sanabria',
                ),
              ),
              const SizedBox(height: 8,),

              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  hintText: 'Ingresa el correo',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contrasena',
                  hintText: 'Ingresa la contrasena',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Numero de telefono',
                  hintText: 'Ingresa tu numero celular',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              ElevatedButton(onPressed: () async{
                context.push(
                        '/selfie?name=${_nameController.text}&password=${_passwordController.text}&email=${_emailController.text}&phone=${_phoneController.text}');

              },child: Text("Registrarse")), 
            ],
          ),
        ),
      ),
    );
  }
}