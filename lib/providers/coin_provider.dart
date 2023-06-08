import 'package:crypto_wallet_app/models/coin.dart';
import 'package:crypto_wallet_app/services/coin_services.dart';
import 'package:flutter/material.dart';

class CoinProvider extends ChangeNotifier {
  CoinService _service = CoinService();
  bool isLoading = false;
  List<Coin> coinList = [];

  List<Coin> get coins => coinList;

  Future<void> getallCoin() async {
    final response = await _service.getAll();

    coinList = response;
    isLoading = false;
    notifyListeners();
  }
}
