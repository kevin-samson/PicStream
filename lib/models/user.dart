class User {
  final String username;
  final String email;
  final String bio;
  final String profilePic;
  final List followers;
  final List following;
  final String? uid;

  User({
    required this.username,
    required this.email,
    required this.bio,
    required this.profilePic,
    required this.followers,
    required this.following,
    this.uid,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'bio': bio,
        'profilePic': profilePic,
        'followers': followers,
        'following': following,
      };

  static User fromJson(Map<String, dynamic> json, String uid) => User(
        uid: uid,
        username: json['username'],
        email: json['email'],
        bio: json['bio'],
        profilePic: json['profilePic'],
        followers: json['followers'],
        following: json['following'],
      );
}
