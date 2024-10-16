import 'package:api_provider_016/config/components/utils.dart';
import 'package:api_provider_016/repository/auth/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthViewModel with ChangeNotifier {
  final Auth authRepository;

  AuthViewModel({required this.authRepository});

  // Loading states
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  // Setters
  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  // Set Loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set Error Message
  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Clear Error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Login with email and password
  Future<void> login(BuildContext context) async {
    setLoading(true);
    clearError();

    try {
      await authRepository.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      // Success message after login
      Utils.toastMessage('Login successful!');
      Navigator.pushNamed(context, '/home'); // Navigate to Home after successful login
    } on FirebaseAuthException catch (e) {
      setErrorMessage(e.message);
      Utils.flushBarErrorMessage(_errorMessage ?? 'An error occurred during login', context);
    } finally {
      setLoading(false);
    }
  }

  // Register new user
  Future<void> register(BuildContext context) async {
    setLoading(true);
    clearError();

    try {
      await authRepository.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      // Success message after registration
      Utils.toastMessage('Account created successfully!');
      Navigator.pushNamed(context, '/home'); // Navigate to Home after successful registration
    } on FirebaseAuthException catch (e) {
      setErrorMessage(e.message);
      Utils.flushBarErrorMessage(_errorMessage ?? 'An error occurred during sign-up', context);
    } finally {
      setLoading(false);
    }
  }

  // Logout user
  Future<void> signOut(BuildContext context) async {
    setLoading(true);

    try {
      await authRepository.signOut();
      // Success message after logout
      Utils.toastMessage('Logged out successfully!');
      Navigator.pushNamed(context, '/login'); // Navigate back to login after logout
    } catch (e) {
      setErrorMessage(e.toString());
      Utils.flushBarErrorMessage(_errorMessage ?? 'An error occurred during logout', context);
    } finally {
      setLoading(false);
    }
  }

  // Check authentication state changes
  Stream<User?> get authStateChanges => authRepository.authStateChanges;
}
