import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/data/models/comment.dart';
import 'package:myapp/data/models/like.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as myuser;
import 'package:myapp/routes/routes_names.dart';

import '../../../core/utils/localStorage/shared_pref_manager.dart';

class HomeController extends GetxController {
  final fireabseFireStore = FirebaseFirestore.instance;
  var listUsers = <myuser.User>[].obs;
  final prefs = Get.find<SharedPredManager>();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<Status> listStatus = <Status>[].obs;
  var isLoading = true.obs;
  var fullName = "".obs;
  var myId = ''.obs;
  var isEmptyList = false.obs;

  Future<void> getStatus({bool isRefresh = false}) async {
    if (isRefresh) {
      listStatus.clear();
    }
    try {
      CollectionReference status = fireabseFireStore.collection('status');
      QuerySnapshot querySnapshot = await status.get();
      for (var e in querySnapshot.docs) {
        listStatus.add(Status.fromJson(e.data() as Map<String, dynamic>));
      }
      if (listStatus.isEmpty) {
        isEmptyList.value = true;
      } else {
        isEmptyList.value = false;
      }
      listStatus.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      update();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getUserNameById(String? id) async {
    Map<String, dynamic> data = await fireabseFireStore
        .collection('users')
        .where('id', isEqualTo: id)
        .get() as Map<String, dynamic>;
    String name = myuser.User.fromJson(data).firstName;
    String lastName = myuser.User.fromJson(data).lastName;
    return "$name $lastName";
  }

  Future<void> getUsers() async {
    try {
      var getIds = listStatus.map((e) => e.userId).toList();
      if (getIds.isNotEmpty) {
        CollectionReference users = firebaseFirestore.collection("users");
        QuerySnapshot querySnapshot =
            await users.where('id', whereIn: getIds).get();
        for (var e in querySnapshot.docs) {
          listUsers.add(myuser.User.fromJson(e.data() as Map<String, dynamic>));
        }
      }
      listUsers;
      update();
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllUsers() async {
    try {
      CollectionReference users = firebaseFirestore.collection("users");
      QuerySnapshot querySnapshot = await users.get();
      for (var e in querySnapshot.docs) {
        listUsers.add(myuser.User.fromJson(e.data() as Map<String, dynamic>));
      }
      listUsers;
      update();
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      prefs.clearAll();
      Get.offAllNamed(RoutesNames.login);
    } catch (e) {
      throw Exception(e);
    }
  }

  showAlertAddStatus() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Write your status and share it",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }

  getDataOfCurrentUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        QuerySnapshot userDataSnapshot = await firebaseFirestore
            .collection('users')
            .where("id", isEqualTo: user.uid)
            .get();
        if (userDataSnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData =
              userDataSnapshot.docs.first.data() as Map<String, dynamic>;
          myuser.User currentUser = myuser.User.fromJson(userData);
          prefs.saveString("userData", jsonEncode(currentUser.toJson()));
        } else {
          await logout();
        }
      } else {
        await logout();
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

  checkAndSave() async {
    String? userData = prefs.getString("userData");
    if (userData == null || userData.isEmpty) {
      await getDataOfCurrentUser();
    }
  }

  getUserData() {
    String? userData = prefs.getString("userData");
    if (userData != null && userData.isNotEmpty) {
      myuser.User currentUser = myuser.User.fromJson(jsonDecode(userData));
      fullName.value = "${currentUser.firstName} ${currentUser.lastName}";
      myId.value = currentUser.id;
    }
  }

  likeUpdates(Like like) async {
    try {
      DocumentReference docRef =
          firebaseFirestore.collection('status').doc(like.status);
      DocumentSnapshot docSnp = await docRef.get();

      if (docSnp.exists) {
        List<dynamic> listLikes = docSnp['listLikes'] ?? [];
        var userLike = listLikes.firstWhere(
          (lk) => myId.value == lk['userId'],
          orElse: () => null,
        );

        if (userLike == null) {
          listLikes.add(like.toJson());
        } else {
          listLikes.removeWhere((like) => like['userId'] == myId.value);
        }
        await docRef.update({'listLikes': listLikes});
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  var textCommentController = TextEditingController();
  commentUpdate(Status status) async {
    try {
      Comment comment = Comment(
          id: '',
          userId: myId.value,
          content: textCommentController.text,
          userFullName: fullName.value,
          createAt: DateTime.now().toString(),
          statusId: status.id!);
      DocumentReference docRef =
          fireabseFireStore.collection('status').doc(status.id!);
      docRef
          .collection('comments')
          .add(comment.toJson())
          .then((DocumentReference doc) {
        fireabseFireStore.collection('status').doc(status.id!);
        docRef.collection('comments').doc(doc.id).update({'id': doc.id});

        var commentCollection = fireabseFireStore
            .collection('status')
            .doc(status.id!)
            .collection('comments');

        commentCollection.get().then((querySnp) {
          int lenght = querySnp.size;
          fireabseFireStore
              .collection('status')
              .doc(status.id!)
              .update({'commentsCount': '$lenght'});
        });
      });
      if (status.listComments!.isEmpty) {
        status.listComments!.add(comment);
      }
      await getCommants(status);

      update();
    } catch (e) {
      throw Exception(e);
    }
  }

  getCommants(Status status) async {
    try {
      QuerySnapshot querySnp = await fireabseFireStore
          .collection('status')
          .doc(status.id)
          .collection('comments')
          .get();
      List<dynamic> comments = querySnp.docs
          .map((doc) => Comment.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      status.listComments!.assignAll(comments as List<Comment>);
      status.listComments!.sort((a, b) =>
          DateTime.parse(b.createAt!).compareTo(DateTime.parse(a.createAt!)));
      update();
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkAndSave();
    await getUserData();
    await getStatus();
    // await getUsers();
    await getAllUsers();
  }
}
