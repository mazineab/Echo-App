import 'package:myapp/data/models/comment.dart';
import 'package:myapp/data/models/like.dart';
import 'package:myapp/data/models/tag.dart';

class Status {
  String? id;
  String content;
  String userId;
  List<Tag> listTags;
  List<Comment>? listComments;
  List<Like>? listLikes;

  Status(
      {this.id,
      required this.userId,
      required this.content,
      required this.listTags,
      required this.listComments,
      required this.listLikes});

  factory Status.fromJson(Map<String, dynamic> data) {
    return Status(
        id: data['id']??'',
        content: data['content'],
        userId: data['userId'],
        listTags: data['listTags']!=null
        ?(data['listTags'] as List<dynamic>).map((e)=>Tag.fromJson(e as Map<String,dynamic>)).toList() 
        : <Tag>[],
        listComments: data['listComments'] !=null
        ?(data['listComments'] as List<dynamic>).map((e)=>Comment.fromJson(e as Map<String,dynamic>)).toList()
        : <Comment>[],
        listLikes: data['listLikes'] !=null
        ?(data['listLikes'] as List<dynamic>).map((e)=>Like.fromJson(e as Map<String,dynamic>)).toList()
        :<Like>[]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id??'',
      'userId':userId,
      'content': content,
      'listTags': listTags,
      'listComments': listComments,
      'listLikes': listLikes,
    };
  }
}
