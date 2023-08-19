class SocialUserModel {
  final String name;
  final String phone;
  String email;
  final String image;
  String imageCover;
  String bio;
  final String uId;
  bool isEmailVerified;

  SocialUserModel({
    required this.name,
    required this.phone,
    this.email = '',
    required this.image,
    this.imageCover = '',
    this.bio = '',
    required this.uId,
    this.isEmailVerified = false,
  });

  factory SocialUserModel.fromJson(jsonData) {
    return SocialUserModel(
        name: jsonData['name'],
        phone: jsonData['phone'],
        email: jsonData['email'],
        uId: jsonData['uId'],
        bio: jsonData['bio'],
        image: jsonData['image'],
        imageCover: jsonData['imagecover'],
        isEmailVerified: jsonData['isEmailVerified']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'image': image,
      'bio': bio,
      'imagecover': imageCover,
      'isEmailVerified': isEmailVerified
    };
  }
}
