import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/ask_dialog.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/common/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as myuser;

import '../models/comment.dart';
import '../models/like.dart';

class StatusRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Status>> getStatus() async {
    List<Status> listStatus = [];
    try {
      CollectionReference status = _firebaseFirestore.collection('status');
      QuerySnapshot querySnapshot = await status.get();
      for (var e in querySnapshot.docs) {
        listStatus.add(Status.fromJson(e.data() as Map<String, dynamic>));
      }
      return listStatus;
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Status>> getStatuss() {
    try {
      return _firebaseFirestore.collection('status').snapshots().map((
          QuerySnapshot query) {
        List<Status> listStatus = [];
        for (var e in query.docs) {
          listStatus.add(Status.fromJson(e.data() as Map<String, dynamic>));
        }
        listStatus.sort((a, b) => b.createAt!.compareTo(a.createAt!));
        return listStatus;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getUserNameById(String? id) async {
    try {
      Map<String, dynamic> data = await _firebaseFirestore
          .collection('users')
          .where('id', isEqualTo: id)
          .get() as Map<String, dynamic>;
      String name = myuser.User
          .fromJson(data)
          .firstName;
      String lastName = myuser.User
          .fromJson(data)
          .lastName;
      return "$name $lastName";
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getProfileOf(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection('users')
          .where('id', isEqualTo: uid)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot docSnp = querySnapshot.docs.first;
        String? profileUrl = docSnp['imageUrl'];
        return profileUrl;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  Future<List<Comment>> getComments({required String statusId}) async {
    try {
      QuerySnapshot querySnp = await _firebaseFirestore
          .collection('status')
          .doc(statusId)
          .collection('comments')
          .get();
      List<dynamic> comments = querySnp.docs
          .map((doc) => Comment.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return comments as List<Comment>;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> commentUpdate(Status status, Comment comment) async {
    try {
      DocumentReference docRef =
      _firebaseFirestore.collection('status').doc(status.id!);
      docRef
          .collection('comments')
          .add(comment.toJson())
          .then((DocumentReference doc) {
        _firebaseFirestore.collection('status').doc(status.id!);
        docRef.collection('comments').doc(doc.id).update({'id': doc.id});

        var commentCollection = _firebaseFirestore
            .collection('status')
            .doc(status.id!)
            .collection('comments');

        commentCollection.get().then((querySnp) {
          int lenght = querySnp.size;
          _firebaseFirestore
              .collection('status')
              .doc(status.id!)
              .update({'commentsCount': '$lenght'});
        });
      });
      if (status.listComments!.isEmpty) {
        status.listComments!.add(comment);
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteStatus(String statusId)async{
    try{
      await _firebaseFirestore.collection('status').doc(statusId).delete();
      CustomSnackbar.showSuccessSnackbar(Get.context!,"status deleted success");
    }catch(e){
      CustomSnackbar.showErrorSnackbar(Get.context!,"Faild to delete this status");
    }
  }

  Future<void> deleteComment({required String statusId, required String commentId})async{
    try{
      CollectionReference collectionComment= _firebaseFirestore.collection('status').doc(statusId).collection('comments');
      await collectionComment.doc(commentId).delete();
      //update list
      List<Comment> listComment=await getComments(statusId: statusId);
      Get.find<BottomSheetController>().setListComment(listComment);


      //update count
      final snapshot=await collectionComment.count().get();
      int res=snapshot.count??0;
      var doc=_firebaseFirestore.collection('status').doc(statusId);
      DocumentSnapshot docSnp=await doc.get();
      Map<String,dynamic>? data=docSnp.data() as Map<String,dynamic>;
      data['commentsCount']=res.toString();
      await doc.update(data);

      CustomSnackbar.showSuccessSnackbar(Get.context!,"Comment deleted success");
    }catch(e){
      CustomSnackbar.showErrorSnackbar(Get.context!,"Faild to delete this comment");
    }
  }

}

