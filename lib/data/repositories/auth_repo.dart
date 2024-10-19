import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as myuser;

class AuthRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;

  Future<bool> login(String email,String password) async {
    try {
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        return true;
      }
      else{
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> register(Map<String,dynamic> userData) async {
    try {
      UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
          email: userData['email'], password:userData['password']);
      if (user.user != null) {
        Map<String,dynamic> data= {
          'id':user.user?.uid??'',
          'firstName': userData['firstName'],
          'lastName': userData['lastName'],
          'email': userData['email'],
          'phoneNumber': userData['phone'],
          'sexe': userData['sexe'] == "Male" ?  "male" : "femel",
          'password': userData['password'],
        };
        myuser.User userReg = myuser.User.fromJson(data);
        DocumentReference docRef =await firebaseFireStore.collection('users').add(userReg.toJson());
        userReg.uId=docRef.id;
        await docRef.update(userReg.toJson());
        return true;
      }else{
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<myuser.User?> getDataOfCurrentUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        QuerySnapshot userDataSnapshot = await firebaseFireStore
            .collection('users')
            .where("id", isEqualTo: user.uid)
            .get();
        if (userDataSnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData =
          userDataSnapshot.docs.first.data() as Map<String, dynamic>;
          myuser.User me=myuser.User.fromJson(userData);

          return me;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }


}