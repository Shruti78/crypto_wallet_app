import 'dart:async';
import 'dart:convert';

import 'package:crypto_wallet_app/models/coin.dart';
import 'package:crypto_wallet_app/providers/coin_provider.dart';
import 'package:crypto_wallet_app/services/coin_services.dart';
import 'package:crypto_wallet_app/widgets/button_widget.dart';
import 'package:crypto_wallet_app/widgets/designs/coins_card.dart';
import 'package:crypto_wallet_app/widgets/total_balance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../widgets/nav_bar.dart';
import '../widgets/title_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CoinProvider>(context, listen: false).getallCoin();
    });
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
                  child: Consumer(
                    builder: (BuildContext context, value, child) {
                      return coinList.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
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
                                    changePercentage: coinList[index]
                                        .changePercentage
                                        .toDouble(),
                                  ),
                                );
                              },
                            );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
