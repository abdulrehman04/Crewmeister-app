class Member {
  final int id;
  final int crewId;
  final String image;
  final String name;
  final int userId;

  Member({
    required this.id,
    required this.crewId,
    required this.image,
    required this.name,
    required this.userId,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      crewId: json['crewId'],
      image: json['image'],
      name: json['name'],
      userId: json['userId'],
    );
  }
}
