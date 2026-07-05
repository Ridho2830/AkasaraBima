import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create user profile in Firestore
  Future<void> createUserProfile({
    required String uid,
    required String email,
    required String fullName,
    required String displayName,
    required String school,
    required String address,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'full_name': fullName,
        'display_name': displayName,
        'school': school,
        'address': address,
        'created_at': FieldValue.serverTimestamp(),
        'last_active_date': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Gagal menyimpan profil pengguna ke database: $e');
    }
  }

  // Get user profile data
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(String uid) async {
    try {
      return await _firestore.collection('users').doc(uid).get();
    } catch (e) {
      throw Exception('Gagal memuat profil pengguna dari database: $e');
    }
  }
}
