import 'package:keepit/data/model/card_entity.dart';
import 'package:keepit/data_source/local/impl_card_local_datasource.dart';
import 'package:keepit/domain/model/card_model.dart';
import 'package:keepit/domain/repositories/card_repository.dart';

class ImplCardRepository implements CardRepository {
  final ImplLocalDataSource _db;

  ImplCardRepository({required ImplLocalDataSource database}) : _db = database;

  @override
  Future<List<CardModel>> getCards() async {
    try {
      final data = await _db.getAll();
      final cards = data
          .map(
            (card) => card.toDomain(),
          )
          .toList();
      return cards;
    } on Exception catch (e) {
      // TODO implement error handling
      print(e.toString());
      throw Exception('Uninplemented');
    }
  }

  @override
  Future<void> addCard(CardModel card) async {
    try {
      await _db.add(CardEntity.fromCard(card));
    } catch (e) {
      // TODO implement error handling
      print(e.toString());
      throw Exception('Uninplemented');
    }
  }

  @override
  Future<void> deleteCard(int id) async {
    try {
      await _db.delete(id);
    } catch (e) {
      // TODO implement error handling
      print(e.toString());
      throw Exception('Uninplemented');
    }
  }

  @override
  Future<void> editCard(CardModel card) async {
    try {
      await _db.edit(CardEntity.fromCard(card));
    } catch (e) {
      // TODO implement error handling
      print(e.toString());
      throw Exception('Uninplemented');
    }
  }
}
