class Comment {
  String id;
  String userId;
  String content;
  List<Comment>? listComments;

  Comment(
      {required this.id,
      required this.userId,
      required this.content,
      this.listComments});

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
        id: data['id'],
        userId: data['userId'],
        content: data['content'],
        // listComment: data['listComment'] ?? <Comment>[]
        listComments: data['listComments'] !=null
        ?(data['listComments'] as List<Comment>).map((e)=>Comment.fromJson(e as Map<String,dynamic>)).toList()
        : <Comment>[]
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'listComment': listComments,
    };
  } 
}
