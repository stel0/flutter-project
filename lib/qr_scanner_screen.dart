import 'dart:developer';

import 'package:curso_de_verano/core/helpers/encryption_helper.dart';
import 'package:curso_de_verano/core/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrScannerScreen extends StatefulWidget {

  static const routeName = "/qr-scanner";


  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  bool isScanned = false;
  String? qrText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Scan QR"),
            Expanded(
                flex: 5,
                child: QRView(key: qrKey, onQRViewCreated: _qrViewCreated)),
            ElevatedButton(
              onPressed: () {},
              child: Text("Scan"),
            ),
          ],
        ),
      ),
    );
  }

  void _qrViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanned) {
        isScanned = true;
        controller.pauseCamera();
        setState(() {
          qrText = scanData.code;
        });
        log(qrText!);
        showQrDataSheet(context, qrText);
      }
    });
  }

  //Crear un BottonSheet que imprima los datos escaneados
  Future<void> showQrDataSheet(BuildContext context, String? qrData) async {
    final decrypted = EncryptorHelper.decrypt(qrData!, "ALLMRsgoJ5lfjwSI");

    AccountModel userData = AccountModel.fromJsonString(decrypted);

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
              expand: true,
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Datos del usuario ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                          child: ClipOval(
                              child: Image.network(userData.photoURL,
                                  width: 200, height: 200, fit: BoxFit.cover))),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(child: Text(userData.uid)),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Nombre",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(userData.name),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(userData.email),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Numero de telefono",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(userData.phoneNumber),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Fecha de Nacimiento",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"),
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }
}