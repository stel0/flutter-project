import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_de_verano/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelfieScreen extends StatefulWidget {
  final String name;
  final String password;
  final String email;
  final String phone;
  const SelfieScreen({super.key,required this.name, required this.password, required this.email, required this.phone});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool? _isInitialized = false;
  bool? _isTakePhoto = false;
  File? selfie;
  bool? _isSignUp = false;

  @override
  void initState(){
    super.initState();
    _isInitializedCamera();
  }

  Future<void> _isInitializedCamera() async{
    _cameras = await availableCameras();

    final fronCamera = _cameras?.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    if(fronCamera != null){
      _cameraController = CameraController(fronCamera, ResolutionPreset.max,enableAudio: false);

      await _cameraController?.initialize();
      setState(()=> _isInitialized=true);
    }

  }

  Future<void> _captureImage()async{
    if(_cameraController == null || !_cameraController!.value.isInitialized) return;
      try{
        final image =await _cameraController!.takePicture();
        final imageFile = File(image.path);
        setState(() {
          _isTakePhoto = true;
          selfie = imageFile;
        });
        _signUp();
      }catch(e){
        log(e.toString());
      }
  }

  
    Future<void> _signUp() async {
    //Llamar a la funcion de firebase auth para registrar.
    UserCredential credential = await FirebaseAuth.instance
     .createUserWithEmailAndPassword(email: widget.email, password: widget.password);

     // Obtener el user id del usuario
     String uid = credential.user!.uid;

    //Subimos la selfie al Firebase Storage

    String uri = "";

    try {
      String fileName = "selfie_${uid}.jpg";

      Reference storageRef = FirebaseStorage.instance.ref().child("selfies/$fileName");


      UploadTask uploadTask = storageRef.putFile(selfie!);
      TaskSnapshot snapshot = await uploadTask;

      uri = await snapshot.ref.getDownloadURL();

    } catch (e) {
      log(e.toString());
    }
    
    
    
    // Guardar los datos del usuario en la coleccion users/ con referencia el uid del usuario registrado
    // /users/{uid}/
    await FirebaseFirestore.instance
     .collection('users')
     .doc(uid)
     .set(
      {
        'name': widget.name,
        'email': widget.email,
        'phone': widget.phone,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
        'photoURL': uri,
      }
     );




    // Redirigir a la pantalla de inicio de session o pop
    context.go(LoginScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        Column(
          children: [
            Center(
              child: Text("Tomate una selfie para registrarte"),
            ),
            const SizedBox(height: 8,),
            if(_isSignUp == false)
              _isInitialized == true 
              ?
              AspectRatio(aspectRatio: _cameraController!.value.aspectRatio,child: Transform.rotate(angle: -1.5708, child: CameraPreview(_cameraController!))) 
              : 
              CircularProgressIndicator(), 

              Spacer(),
              ElevatedButton(onPressed: ()async{
                await _captureImage();
              }, child: Text("Tomar foto")),
            CircularProgressIndicator(), 
              
            
          ],
        )
      ),
    );
  }
}