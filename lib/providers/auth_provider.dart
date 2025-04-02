import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';
  
  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  String get errorMessage => _errorMessage;
  
  AuthProvider() {
    _initializeUser();
  }
  
  void _initializeUser() {
    _user = FirebaseService.auth.currentUser;
    notifyListeners();
  }
  
  Future<bool> signUp(String email, String password, String name) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      
      UserCredential userCredential = await FirebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await FirebaseService.firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'favorites': [],
      });
      
      _user = userCredential.user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      
      UserCredential userCredential = await FirebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      _user = userCredential.user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  Future<void> signOut() async {
    await FirebaseService.auth.signOut();
    _user = null;
    notifyListeners();
  }
}
