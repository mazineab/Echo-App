import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/data/models/enums.dart';
import 'package:myapp/data/models/tag.dart';
import 'package:myapp/data/models/user.dart';

class AddStatusController extends GetxController {
  final prefs = Get.find<SharedPredManager>();
  var fullname = "".obs;
  // var list = <Tags>{}.obs;
  final List<Tag> tags = [
    Tag(Tags.Development, Icons.code),
    Tag(Tags.Economy, Icons.monetization_on),
    Tag(Tags.Technology, Icons.computer),
    Tag(Tags.Science, Icons.science),
    Tag(Tags.Health, Icons.health_and_safety),
    Tag(Tags.Education, Icons.school),
    Tag(Tags.Environment, Icons.nature),
    Tag(Tags.Politics, Icons.gavel),
    Tag(Tags.Culture, Icons.public),
    Tag(Tags.Society, Icons.group),
    Tag(Tags.Sports, Icons.sports),
    Tag(Tags.Entertainment, Icons.theater_comedy),
    Tag(Tags.Art, Icons.palette),
    Tag(Tags.Travel, Icons.travel_explore),
    Tag(Tags.Food, Icons.food_bank),
    Tag(Tags.Fashion, Icons.style),
    Tag(Tags.Fitness, Icons.fitness_center),
    Tag(Tags.Music, Icons.music_note),
    Tag(Tags.Movies, Icons.movie),
    Tag(Tags.Books, Icons.book),
    Tag(Tags.Gaming, Icons.videogame_asset),
    Tag(Tags.Business, Icons.business),
    Tag(Tags.Finance, Icons.attach_money),
    Tag(Tags.Innovation, Icons.lightbulb),
    Tag(Tags.News, Icons.article),
    Tag(Tags.History, Icons.history),
    Tag(Tags.Philosophy, Icons.book_online),
    Tag(Tags.Psychology, Icons.psychology),
    Tag(Tags.Nature, Icons.nature_people),
  ];

  fetchLocalData() {
    String? userData = prefs.getString("userData");
    if (userData != null) {
      User user = User.fromJson(jsonDecode(userData));
      fullname.value = "${user.firstName} ${user.lastName}";
    }
  }

  showDialogOfTags() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Selcted tags"),
            content: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0, // Horizontal spacing between tags
                runSpacing: 4.0, // Vertical spacing between lines
                children: tags.map((tag) => tagWidget(tag: tag)).toList(),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: const Text("OK"))
            ],
          );
        });
  }

  Widget tagWidget({required Tag tag}) {
    return Chip(
      avatar: Icon(
        tag.icon,
        color: Colors.white,
      ),
      label: Text(
          style: const TextStyle(color: Colors.white),
          tag.tag.toString().split('.').last),
      backgroundColor: const Color(0xFF2c2d30).withOpacity(0.8),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchLocalData();
  }
}
