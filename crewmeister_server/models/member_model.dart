class Member {
  Member({
    required this.id,
    required this.crewId,
    required this.image,
    required this.name,
    required this.userId,
  });
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as int,
      crewId: json['crewId'] as int,
      image: json['image'] as String,
      name: json['name'] as String,
      userId: json['userId'] as int,
    );
  }
  final int id;
  final int crewId;
  final String image;
  final String name;
  final int userId;
}
