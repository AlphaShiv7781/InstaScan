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

}