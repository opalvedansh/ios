import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/exceptions.dart';

class AuthService {
  final auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthService({
    auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _auth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  // Auth state stream
  Stream<auth.User?> get authStateChanges => _auth.authStateChanges();

  // Current user
  auth.User? get currentUser => _auth.currentUser;

  // Phone OTP verification
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
    Function(auth.PhoneAuthCredential)? onAutoVerified,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (auth.PhoneAuthCredential credential) async {
          if (onAutoVerified != null) {
            onAutoVerified(credential);
          } else {
            await _auth.signInWithCredential(credential);
          }
        },
        verificationFailed: (auth.FirebaseAuthException e) {
          onError(e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      throw AuthException('Failed to verify phone number: $e');
    }
  }

  // Verify OTP code
  Future<auth.UserCredential> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final credential = auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw AuthException('Invalid OTP: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get user role from custom claims
  Future<String?> getUserRole() async {
    final user = currentUser;
    if (user == null) return null;

    final idTokenResult = await user.getIdTokenResult();
    return idTokenResult.claims?['role'] as String?;
  }

  // Check if staff is verified (for staff app login)
  Future<bool> isStaffVerified() async {
    final user = currentUser;
    if (user == null) return false;

    final role = await getUserRole();
    if (role != 'staff') return false;

    // Check staff document
    final staffDoc = await _firestore
        .collection('staff')
        .where('phone', isEqualTo: user.phoneNumber)
        .limit(1)
        .get();

    if (staffDoc.docs.isEmpty) return false;

    return staffDoc.docs.first.data()['isVerified'] == true;
  }
}
