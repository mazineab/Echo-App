import 'package:intl/intl.dart';
import 'package:myapp/data/models/comment.dart';
import 'package:myapp/data/models/like.dart';
import 'package:myapp/data/models/tag.dart';

class Status {
  String? id;
  String content;
  String userId;
  String? fullUserName;
  List<Tag> listTags;
  String? commentCount;
  List<Like>? listLikes;
  List<Comment>? listComments;
  String? createAt;

  Status(
      {this.id,
      required this.userId,
      required this.content,
      required this.listTags,
      required this.commentCount,
      required this.fullUserName,
      required this.listComments,
      required this.createAt,
      required this.listLikes});

  factory Status.fromJson(Map<String, dynamic> data) {
    return Status(
        id: data['id'] ?? '',
        content: data['content'],
        userId: data['userId'],
        listTags: data['listTags'] != null
            ? (data['listTags'] as List<dynamic>)
                .map((e) => Tag.fromJson(e as Map<String, dynamic>))
                .toList()
            : <Tag>[],
        fullUserName: data['fullUserName'] ?? '',
        commentCount: data['commentsCount'] ?? '',
        listComments: data['listComments'] != null
            ? (data['listComments'] as List<dynamic>)
                .map((e) => Comment.fromJson(e as Map<String, dynamic>))
                .toList()
            : <Comment>[],
        createAt: data['createAt'] ?? '',
        listLikes: data['listLikes'] != null
            ? (data['listLikes'] as List<dynamic>)
                .map((e) => Like.fromJson(e as Map<String, dynamic>))
                .toList()
            : <Like>[]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'userId': userId,
      'content': content,
      'listTags': listTags,
      'listComments': listComments,
      'commentsCount': commentCount ?? '',
      'fullUserName': fullUserName ?? '',
      'listLikes': listLikes,
      'createAt': createAt
    };
  }

  formateDate() {
    try {
      DateTime parseDate = DateTime.parse(createAt ?? '');
      return DateFormat("dd/MM/yyyy hh:mm").format(parseDate);
    } catch (e) {
      Exception(e);
      return '';
    }
  }

  // List<Comment> sortedComments() {
  //   try{
  //     return listComments!.sort((a, b) => b.createAt!.compareTo(a.createAt!));
  //   }catch(e){
  //     Exception(e);
  //   }
  // }
}
