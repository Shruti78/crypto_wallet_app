import 'dart:async';
import 'dart:convert';

import 'package:crypto_wallet_app/models/coin.dart';
import 'package:crypto_wallet_app/widgets/button_widget.dart';
import 'package:crypto_wallet_app/widgets/designs/coins_card.dart';
import 'package:crypto_wallet_app/widgets/total_balance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/nav_bar.dart';
import '../widgets/title_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=kjk&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));

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
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b232A),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: TotalBalance(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 75,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(text: "Coins", onTap: () {}, active: true),
                    ButtonWidget(text: "Deposit", onTap: () {}, active: false),
                    ButtonWidget(text: "Withdraw", onTap: () {}, active: false),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: TittleBar()),
            SliverToBoxAdapter(
              child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: coinList.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: CoinCardDesign(
                          name: coinList[index].name,
                          symbol: coinList[index].symbol,
                          imageUrl: coinList[index].imageUrl,
                          price: coinList[index].price.toDouble(),
                          change: coinList[index].change.toDouble(),
                          changePercentage:
                              coinList[index].changePercentage.toDouble(),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GlassBottomNav(
        onPressed: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
