class Post {
  final String caption;
  final String imageUrl;
  final String uid;
  final String username;
  final DateTime date;
  final String profileImg;
  final List likes;

  Post({
    required this.caption,
    required this.imageUrl,
    required this.uid,
    required this.username,
    required this.date,
    required this.profileImg,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'imageUrl': imageUrl,
      'uid': uid,
      'username': username,
      'date': date,
      'profileImg': profileImg,
      'likes': likes,
    };
  }

  static Post fromJson(Map<String, dynamic> json) => Post(
        caption: json['caption'],
        imageUrl: json['imageUrl'],
        uid: json['uid'],
        username: json['username'],
        date: json['date'],
        profileImg: json['profileImg'],
        likes: json['likes'],
      );
}
