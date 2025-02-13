import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_de_verano/core/helpers/account_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  bool isInitialized = false;

  //Atributo que guarde los datos del usuario logueado
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    // Obtener el uid del usuario
    final uid = FirebaseAuth.instance.currentUser!.uid;

    log(uid);

    // Con el uid del usuario vamos a consultar en Firestore /users/{uid} y traeremos los datos del usuario
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    // Mapeamos los datos y devolvemos
    userData = snapshot.data()! as Map<String, dynamic>;

    AccountHelper.instance.setCurrentUser(userData!);

    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: SafeArea(
        child: 
        isInitialized
            ? 
            Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Bienvenido al Curso de Verano",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Datos del Usuario"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Nombre : '),
                        const SizedBox(
                          width: 8,
                        ),
                        if (userData != null) Text(userData!['name'] ?? ""),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text('Email : '),
                        const SizedBox(
                          width: 8,
                        ),
                        if (userData != null) Text(userData!['email']),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text('Telefono : '),
                        const SizedBox(
                          width: 8,
                        ),
                        if (userData != null) Text(userData!['phone']),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            : 
            Center(child: CircularProgressIndicator()),
      ),
    );
  }
}