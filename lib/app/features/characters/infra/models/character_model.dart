class CharacterModel {
  final int id;
  final String name;
  final String description;

  CharacterModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
