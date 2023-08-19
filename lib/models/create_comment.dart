class CraeteCommentModel {
  final String name;
  final String image;
  final String uId;
  final String date;
  final String comments;
  final String postUid;

  // String postImage;

  CraeteCommentModel({
    required this.name,
    required this.image,
    required this.comments,
    required this.date,

    // required this.postImage,
    required this.uId,
    required this.postUid,
  });

  factory CraeteCommentModel.fromJson(jsonData) {
    return CraeteCommentModel(
      name: jsonData['name'],
      uId: jsonData['uId'],
      image: jsonData['image'],
      date: jsonData['date'],
      postUid: jsonData['postUid'],
      comments: jsonData['comments'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'date': date,
      'postUid': postUid,
      'comments': comments,
    };
  }
}
