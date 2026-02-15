import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../core/constants/firestore_paths.dart';
import '../core/errors/app_exception.dart';

class AuthService {
  AuthService({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<User> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException('Sign-in was cancelled');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        throw const AuthException('Sign-in failed: no user returned');
      }

      await _ensureUserProfile(user);
      return user;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Sign-in failed', e);
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw AuthException('Sign-out failed', e);
    }
  }

  Future<void> _ensureUserProfile(User user) async {
    final docRef = _firestore.doc(FirestorePaths.user(user.uid));
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        'displayName': user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL ?? '',
        'totalCars': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
