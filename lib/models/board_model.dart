class BoardModel {
  final String id;
  final String title;
  final String background;

  BoardModel({required this.id, required this.title, required this.background});

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'],
      title: json['title'],
      background: json['background'] ?? 'lib/assets/images/bg/bg1.jpg',
    );
  }
}
