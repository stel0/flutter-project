import 'package:curso_de_verano/core/helpers/account_helper.dart';
import 'package:curso_de_verano/core/helpers/encryption_helper.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccountScreen extends StatefulWidget {

  static const routeName = "/account";


  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                  child: Text(
                "Datos de mi cuenta",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 16),
              // Vamos a agregar la imagen de la cuenta
              Center(
                  child: ClipOval(
                      child: Image.network(
                          AccountHelper.instance.getCurrentUser()!.photoURL,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover))),

              SizedBox(
                height: 16,
              ),
              Center(
                  child: Text(
                AccountHelper.instance.getCurrentUser()!.uid,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 8,
              ),
              Text("Nombre: ${AccountHelper.instance.getCurrentUser()!.name}"),
              SizedBox(height: 8),
              Text("Email: ${AccountHelper.instance.getCurrentUser()!.email}"),
              SizedBox(height: 8),
              Text(
                  "Teléfono: ${AccountHelper.instance.getCurrentUser()!.phoneNumber}"),
              SizedBox(height: 16),
              // Center(
              //     child: QrImageView(
              //   data: EncryptorHelper.encrypt(
              //       AccountHelper.instance.getCurrentUser()!.toJson(),
              //       "ALLMRsgoJ5lfjwSI"),
              //   size: 250,
              // ))
            ],
          ),
        ),
      ),
    );
  }
}