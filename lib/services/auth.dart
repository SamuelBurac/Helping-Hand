import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> resetPass(email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> updateEmail(email, password) async {
    if (user == null) {
      throw Exception('User is null');
    }
    AuthCredential credential = EmailAuthProvider.credential(
    email: user!.email!,
    password: password,
  );
    await user!.reauthenticateWithCredential(credential);
    await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);
  }
}
