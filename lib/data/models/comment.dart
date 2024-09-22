class Comment {
  String id;
  String userId;
  String content;
  String statusId;
  String? userFullName;
  String? createAt;
  // List<Comment>? listComments;

  Comment(
      {required this.id,
      required this.userId,
      required this.content,
      required this.statusId,
      required this.userFullName,
      required this.createAt
      // this.listComments
      });

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
        id: data['id'] ?? '',
        userId: data['userId'] ?? '',
        content: data['content'] ?? '',
        statusId: data['statusId'] ?? '',
        userFullName: data['userFullName'] ?? '',
        createAt:data['createAt'] ?? ''
        // listComment: data['listComment'] ?? <Comment>[]
        // listComments: data['listComments'] !=null
        // ?(data['listComments'] as List<Comment>).map((e)=>Comment.fromJson(e as Map<String,dynamic>)).toList()
        // : <Comment>[]
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'statusId': statusId,
      'content': content,
      'userFullName': userFullName,
      'createAt':createAt
      // 'listComment': listComments,
    };
  }
}
