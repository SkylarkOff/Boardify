class WorkspaceModel {
  final String id;
  final String name;

  WorkspaceModel({required this.id, required this.name});

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) {
    return WorkspaceModel(id: json['id'], name: json['name']);
  }
}
