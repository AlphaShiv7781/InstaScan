import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {

  Future<UserCredential> signUp(
      String email, String password) async {

      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
  }

     Future<dynamic> signIn(String email , String password )async{

       try{

            final user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
           return user;
       }
       catch(e)
       {
         print(e);
       }

     }


}

