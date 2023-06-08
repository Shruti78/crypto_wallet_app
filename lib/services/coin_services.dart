import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto_wallet_app/models/coin.dart';

class CoinService{
  Future<List<Coin>> getAll() async{
final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
       
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }
}

