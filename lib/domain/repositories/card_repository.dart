import 'package:keepit/domain/model/card_model.dart';

abstract class CardRepository {
  Future<List<CardModel>> getCards();
  Future<void> addCard(CardModel card);
  Future<void> editCard(CardModel card);
  Future<void> deleteCard(int id);
}
