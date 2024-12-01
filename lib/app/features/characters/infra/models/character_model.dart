import '../../domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel({
    required super.id,
    required super.name,
    required super.description,
    required super.thumbnail,
  });

  static CharacterEntity fromJson(Map<String, dynamic> json) {
    return CharacterEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: _thumbnailUrl(json['thumbnail']),
    );
  }

  static String _thumbnailUrl(Map<String, dynamic> json) {
    return '${json['path']}.${json['extension']}';
  }
}
