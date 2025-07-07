import 'package:keepit/domain/model/card_model.dart';

class CardEntity {
  final int? id;
  final String name;
  final String value;
  final String? description;

  CardEntity({
    required this.id,
    required this.name,
    required this.value,
    required this.description,
  });
  factory CardEntity.fromJson(Map<String, dynamic> map) {
    return CardEntity(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'description': description,
    };
  }

  factory CardEntity.fromCard(CardModel card) {
    return CardEntity(
      id: card.id,
      name: card.name,
      value: card.value,
      description: card.description,
    );
  }
  CardModel toDomain() {
    return CardModel(
      id: id,
      name: name,
      value: value,
      description: description,
    );
  }

  static CardEntity fromDomain(CardModel card) {
    return CardEntity(
      id: card.id,
      name: card.name,
      value: card.value,
      description: card.description,
    );
  }

  @override
  String toString() {
    return id == null
        ? 'CardEntity(name: $name, value: $value, description: $description)'
        : 'CardEntity(id: ${id ?? ''}, name: $name, value: $value, description: $description)';
  }
}
