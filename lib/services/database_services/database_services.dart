import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseRetrieval {
  Future<Map<String, dynamic>?> getUserDataByUID(String uid) async {
    try {
      // Reference to the Firestore collection for users
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Retrieve the user document using the provided UID
      DocumentSnapshot document = await users.doc(uid).get();
      print("✅ document $document");

      print("✅ ${document.exists}");
      // Check if the document exists
      if (document.exists) {
        // Convert the document data to a Map and return it
        return document.data() as Map<String, dynamic>;
      } else {
        // Document with the provided UID does not exist
        return null;
      }
    } catch (e) {
      // Handle any errors that may occur during data retrieval
      return null;
    }
  }

}