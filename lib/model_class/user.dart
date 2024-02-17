class User {
  final String name;
  final String email;
  final String image;
  final String region;
  final String mobile;
  final String zone;
  final bool isOnline;

  User({
    required this.name,
    required this.email,
    required this.image,
    required this.region,
    required this.mobile,
    required this.zone,
    required this.isOnline,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['Name'],
      email: json['Email'],
      image: json['image'],
      region: json['region'],
      mobile: json['mobile'],
      zone: json['zone'],
      isOnline: json['isOnline'],
    );
  }
}