import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices{

       Future<void> saveUser(String name , String email , String phoneNumber , String uid)async {

          await FirebaseFirestore.instance.collection('user').
          doc(uid).
          set({
                'name':name ,
                'email':email ,
                'phoneNumber':phoneNumber
          });

      }

       Future<dynamic> getUserData(String userId) async {
         DocumentSnapshot doc = await FirebaseFirestore.instance
             .collection('users')
             .doc(userId)
             .get();

         if (doc.exists) {
           return doc;
         } else {
           return "Unable to Load";
         }
       }


}