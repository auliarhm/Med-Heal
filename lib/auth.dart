import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.disconnect(); // Logout Google
  }

  Future<UserCredential> signInWithGoogle() async {
    // Memulai proses login Google
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

    // Batalkan jika pengguna membatalkan login
    if (gUser == null) throw Exception("Login Google dibatalkan");

    // Mengautentikasi dengan Google
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Mendapatkan kredensial untuk Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Login ke Firebase
    return await _firebaseAuth.signInWithCredential(credential);
  }
}