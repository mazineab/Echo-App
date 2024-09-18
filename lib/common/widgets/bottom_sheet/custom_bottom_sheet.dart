import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/custom_list_tile.dart';
import '../../../data/models/status.dart';

class CustomBottomSheet extends StatelessWidget {
  final Status status;

  CustomBottomSheet({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Fixed height of 400
      child: Column(
        children: [
          Expanded(
            child: status.listComments!.isEmpty
                ? const Center(
                    child: Text(
                      'No comments yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: ListView.builder(
                      itemCount: status.listComments!.length,
                      itemBuilder: (context, index) {
                        return CustomListTile(
                          title: status.listComments![index].content,
                          subtitle: status.listComments![index].content,
                        );
                      },
                    ),
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            margin: const EdgeInsets.only(bottom: 10,left: 10,right: 10), // Bottom margin for spacing
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 215, 212, 212),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Handle comment send logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
