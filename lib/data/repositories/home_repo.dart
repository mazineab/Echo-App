import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as my_user;

class HomeRepo{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;


  Future<bool> addStatus(Map<String,dynamic> data)async{
    try {
      await firebaseFireStore
          .collection('status')
          .add(data)
          .then((DocumentReference doc) {
        firebaseFireStore
            .collection('status')
            .doc(doc.id)
            .update({'id': doc.id}).then((_) async {
              return true;
        });
      });
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getUserDataById(String userId) async {
    try {
      CollectionReference usersCollection = firebaseFireStore.collection('users');
      QuerySnapshot querySnapshot = await usersCollection.where('id', isEqualTo: userId).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot docSnapshot = querySnapshot.docs.first;
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception("No user found with the given ID");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

  Future<int?> getStatusCount(String userId)async{
    try{
      final snapshot=await firebaseFireStore.collection('status').where('userId',isEqualTo: userId).count().get();
      return snapshot.count;
    }catch(e){
      throw Exception("Error fetching status count : $e");
    }
  }


  Future<List<Status>> getStatusOfUser(String userId)async{
    try {
      List<Status> listStatus=<Status>[];
      CollectionReference docRef = firebaseFireStore.collection('status');
      QuerySnapshot querySnapshot = await docRef.where('userId', isEqualTo: userId).get();
      listStatus=querySnapshot.docs.map((e)=>Status.fromJson(e.data() as Map<String,dynamic>)).toList();
      return listStatus;
    } catch (e) {
      throw Exception(e);
    }
  }
}