class CardModel {
  final int? id;
  final String name;
  final String value;
  final String? description;

  CardModel({
    this.id,
    required this.name,
    required this.value,
    required this.description,
  });

  @override
  String toString() {
    return 'CardModel(id: $id, name: $name, number: $value, description: $description)';
  }
}
