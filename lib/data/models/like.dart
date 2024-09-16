class Like {
  String userId;
  String status;

  Like(
      {
      required this.userId,
      required this.status,
      });
      factory Like.fromJson(Map<String, dynamic> data) {
    return Like(
        userId: data['userId'],
        status: data['status'],
       );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'status': status,
    };
  }
}
