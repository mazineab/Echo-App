import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/data/models/comment.dart';
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

  Future<bool> updateStatus(String statusId,Map<String,dynamic> data)async{
    try{
      DocumentReference docRef= firebaseFireStore.collection('status').doc(statusId);
      await docRef.update(data);
      return true;
    }catch(e){
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

  Future<List<Comment>> getCommentOfUser(String userId)async{
    try{
      List<Map<String, dynamic>> allUserComments = [];

      
      CollectionReference statusCollection = firebaseFireStore.collection('status');
      QuerySnapshot statusSnapshot = await statusCollection.get();
      for (var statusDoc in statusSnapshot.docs) {
        CollectionReference commentsCollection = statusDoc.reference.collection('comments');
        QuerySnapshot commentsSnapshot = await commentsCollection.where('userId', isEqualTo: userId).get();

        for (var commentDoc in commentsSnapshot.docs) {
          allUserComments.add(commentDoc.data() as Map<String, dynamic>);
        }
      }

      return allUserComments.map((e)=>Comment.fromJson(e)).toList();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<my_user.User>> getUsers()async{
    try{
      QuerySnapshot querySnapshot=await firebaseFireStore.collection('users').get();
      List<my_user.User> listUsers=querySnapshot.docs.map((e)=>my_user.User.fromJson(e.data() as Map<String,dynamic>)).toList();
      return listUsers;
    }catch(e){
      throw e;
    }
  }
}