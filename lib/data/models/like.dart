class Like {
  String id;
  String userId;
  String status;
  String isLike;

  Like(
      {required this.id,
      required this.userId,
      required this.status,
      required this.isLike});
      factory Like.fromJson(Map<String, dynamic> data) {
    return Like(
        id: data['id'],
        userId: data['userId'],
        status: data['status'],
        isLike: data['isLike']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'isLike': isLike,
    };
  }
}
