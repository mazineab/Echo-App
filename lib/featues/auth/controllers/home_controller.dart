import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/data/models/user.dart';

class HomeController extends GetxController {
  var listUsers = <User>[].obs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> getUsers() async {
    // QuerySnapshot querySnapshot =
    //     await _firebaseFirestore.collection("users").get();
    CollectionReference users = firebaseFirestore.collection("users");
    QuerySnapshot querySnapshot = await users.get();
    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.docs.forEach((e) {
      listUsers.add(User.fromJson(e.data() as Map<String, dynamic>));
    });
    listUsers;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUsers();
  }
}
