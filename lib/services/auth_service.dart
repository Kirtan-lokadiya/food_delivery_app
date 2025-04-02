import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Stream of auth changes
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Register with email and password
  static Future<UserCredential> registerWithEmailAndPassword(
      String email, String password, String name, String phoneNumber) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      await _firestore.collection('users').doc(result.user!.uid).set({
        'id': result.user!.uid,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'favoriteRestaurants': [],
        'orderHistory': [],
        'isDarkMode': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Reset password
  static Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Update user profile
  static Future<void> updateUserProfile({
    String? name,
    String? phoneNumber,
    String? profileImage,
    bool? isDarkMode,
  }) async {
    try {
      final user = currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          if (name != null) 'name': name,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
          if (profileImage != null) 'profileImage': profileImage,
          if (isDarkMode != null) 'isDarkMode': isDarkMode,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get user data
  static Future<UserModel?> getUserData() async {
    try {
      final user = currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromJson(doc.data()!);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
} 