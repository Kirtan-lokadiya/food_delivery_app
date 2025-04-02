import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDRGH1W-x0SgJo7rSJM3C7DKhwmLOd8sm0",
        authDomain: "mad-internal-practical.firebaseapp.com",
        projectId: "mad-internal-practical",
        storageBucket: "mad-internal-practical.firebasestorage.app",
        messagingSenderId: "270249682689",
        appId: "1:270249682689:web:e24bf6c0b05e7bd35f5d00",
        measurementId: "G-FXD7Z9V24P"
      ),
    );
  }

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
}
