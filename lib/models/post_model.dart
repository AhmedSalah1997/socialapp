class PostModel {
  final String name;
  final String image;
  String uId;
  final String date;
  String text;
  String postImage;
  // final String postuId;

  PostModel({
    required this.name,
    required this.image,
    this.text = '',
    required this.date,
    required this.postImage,
    this.uId = '',
    // required this.postuId,
  });

  factory PostModel.fromJson(jsonData) {
    return PostModel(
      name: jsonData['name'],
      uId: jsonData['uId'],
      image: jsonData['image'],
      date: jsonData['date'],
      postImage: jsonData['postimage'],
      text: jsonData['text'],
      // postuId: jsonData['postuId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'date': date,
      'postimage': postImage,
      'text': text,
      // 'postuId': postuId
    };
  }
}
