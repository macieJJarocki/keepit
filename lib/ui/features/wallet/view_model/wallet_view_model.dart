import 'package:flutter/material.dart';
import 'package:keepit/data/repositories/impl_card_repository.dart';
import 'package:keepit/domain/model/card_model.dart';

class WalletViewModel with ChangeNotifier {
  final ImplCardRepository cardRepo;
  List<CardModel> _cards = [];
  List<CardModel> get cards => _cards;

  WalletViewModel(this.cardRepo);
  Future<void> getCards() async {
    try {
      _cards = await cardRepo.getCards();
      notifyListeners();
    } on Exception catch (e) {
      // TODO implement error handling
      print(e.toString());
    }
  }

  Future<void> addCard(String name, String number, String description) async {
    try {
      await cardRepo.addCard(
        CardModel(name: name, value: number, description: description),
      );
      await getCards();
    } on Exception catch (e) {
      // TODO implement error handling
      print(e.toString());
    }
  }

  Future<void> editCard(CardModel card) async {
    try {
      await cardRepo.editCard(card);
      await getCards();
    } on Exception catch (e) {
      // TODO implement error handling
      print(e.toString());
    }
  }

  Future<void> deleteCard(int id) async {
    try {
      await cardRepo.deleteCard(id);
      await getCards();
    } on Exception catch (e) {
      // TODO implement error handling
      print(e.toString());
    }
  }
}
