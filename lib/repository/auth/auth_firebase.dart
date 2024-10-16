import 'package:firebase_auth/firebase_auth.dart';


class Auth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();


  Future<void> signInWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  print('Signing in with email: $email');  // Debugging line
  try {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('Sign in successful');  // Debugging line
  } catch (e) {
    
    print('Sign in error: $e');  // Debugging line
    rethrow;
  }
}



  
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword
    (email: email,
     password: password
     );
  }

  Future<void> signOut()async{
    await _firebaseAuth.signOut();
  }
}