import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instascan/constants/constant.dart';

class FirestoreServices{

       Future<void> saveUser(String name , String email , String phoneNumber , String uid)async {

          await FirebaseFirestore.instance.collection(userCollection).
          doc(uid).
          set({
                'name':name ,
                'email':email ,
                'phoneNumber':phoneNumber
          });

      }

       Future<void> savePDFUrl(String userId, String pdfUrl) async {
         final CollectionReference historyCollection = FirebaseFirestore.instance
             .collection('users')
             .doc(userId)
             .collection('history');

         try {
           await historyCollection.add({
             'url': pdfUrl,  // ✅ Store Cloudinary URL
             'timestamp': FieldValue.serverTimestamp(), // ✅ Used for ordering
           });

           print("✅ PDF URL successfully added to Firestore for user: $userId");

         } catch (e) {
           print("❌ Firestore Write Error: $e");
         }
       }

       Future<void> fetchPDFs() async {
         final CollectionReference pdfCollection =
         FirebaseFirestore.instance.collection('pdfs');

         final snapshot = await pdfCollection.get();
         for (var doc in snapshot.docs) {
           print("PDF URL: ${doc['url']}");
         }
       }



}