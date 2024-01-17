import 'package:crypto_market/Crypto_Market/Model/coin_model.dart';
import 'package:crypto_market/crypto_market.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nft_marketplace/colors.dart';
import 'package:nft_marketplace/data_variables.dart';
import 'package:nft_marketplace/provider/refresh_screen_provider.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';
import 'package:nft_marketplace/wallet/ui/transaction_screen.dart';
import 'package:provider/provider.dart';

class WalletHomePage extends StatefulWidget {
  WalletHomePage({Key? key}) : super(key: key);

  @override
  State<WalletHomePage> createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  List<Coin> list = [
    Coin(
      id: '1',
      image: 'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png',
      name: 'Bitcoin',
      shortName: 'BTC',
      price: '123456',
      lastPrice: '123456',
      percentage: '-0.5',
      symbol: 'BTCUSDT',
      pairWith: 'USDT',
      highDay: '567',
      lowDay: '12',
      decimalCurrency: 4,
    ),
    Coin(
      id: '1',
      image: 'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png',
      name: 'Bitcoin',
      shortName: 'BTC',
      price: '123456',
      lastPrice: '123456',
      percentage: '-0.5',
      symbol: 'BTCUSDT',
      pairWith: 'INR',
      highDay: '567',
      lowDay: '12',
      decimalCurrency: 4,
    ),
    Coin(
      id: '2',
      image: 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png',
      name: 'Ethereum',
      shortName: 'ETH',
      price: '123456',
      lastPrice: '123456',
      percentage: '-0.5',
      symbol: 'ETHUSDT',
      pairWith: 'USDT',
      highDay: '567',
      lowDay: '12',
      decimalCurrency: 4,
    ),
    Coin(
      id: '2',
      image: 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png',
      name: 'Ethereum',
      shortName: 'ETH',
      price: '123456',
      lastPrice: '123456',
      percentage: '-0.5',
      symbol: 'ETHUSDT',
      pairWith: 'INR',
      highDay: '567',
      lowDay: '12',
      decimalCurrency: 4,
    ),
  ];

  List<String> currencyList = [
    'USDT',
    'INR',
  ];

  List<String> tickerList = [
    "btcusdt@ticker",
    "ethusdt@ticker",
    "winusdt@ticker",
    "dentusdt@ticker",
    "xrpusdt@ticker",
    "etcusdt@ticker",
    "dogeusdt@ticker",
    "bnbusdt@ticker",
    "cakeusdt@ticker",
    "maticusdt@ticker",
    "trxusdt@ticker",
    "usdcusdt@ticker",
    "sandusdt@ticker",
    "maticbtc@ticker",
    "polybtc@ticker",
    "bnbbtc@ticker",
    "xrpeth@ticker",
    "shibusdt@ticker",
  ];

  List<Coin> wishlistCoinsList = [
    Coin(
      id: '1',
      image: 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png',
      name: 'Ethereum',
      shortName: 'ETH',
      price: '123456',
      lastPrice: '123456',
      percentage: '-0.5',
      symbol: 'ETHUSDT',
      pairWith: 'USDT',
      highDay: '567',
      lowDay: '12',
      decimalCurrency: 4,
    )
  ];

  String formatNumber(String price, double amount) {
    final total = double.parse(price) * amount;
    String formattedNumber = total.toStringAsFixed(2);
    return formattedNumber;
  }

  double formatAmount(double amount) {
    String formattedNumber = amount.toStringAsFixed(2);
    return double.parse(formattedNumber);
  }

  _container(String coin, double amount, String imageUrl, String totalAmountINR,
      String totalAmountUSD) {
    return Container(
      height: 125,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blueAccent,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "$coin : $amount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Image.network(
                  imageUrl,
                  height: 40,
                  width: 40,
                ),
                const Gap(10),
              ],
            ),
            const Text(
              "Total",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                const Text(
                  "USD",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  totalAmountINR,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Gap(3),
            Row(
              children: [
                const Text(
                  "INR",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  totalAmountUSD,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RefreshScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wallet"),
        forceMaterialTransparency: true,
        actions: [
          SizedBox(
            width: 63,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionScreenWidget(),
                  ),
                );
              },
              icon: Image.asset(
                "assets/images/transaction.png",
                height: 35,
                width: 35,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: RefreshIndicator(
          onRefresh: provider.onRefresh,
          color: Colors.white,
          backgroundColor: ColorsData.selectiveYellow,
          strokeWidth: 2,
          child: FutureBuilder(
            future: WalletDataManager.getWallet(user.uid),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final resultData = snapshot.data;
                return Column(
                  children: [
                    _container(
                      list[0].name,
                      formatAmount(resultData!.coin!.bitcoin!),
                      list[0].image,
                      formatNumber(list[0].price, resultData.coin!.bitcoin!),
                      formatNumber(
                          list[1].price, resultData.coin!.bitcoin! * 77),
                    ),
                    const Gap(10),
                    _container(
                      list[2].name,
                      formatAmount(resultData.coin!.ethereum!),
                      list[2].image,
                      formatNumber(list[2].price, resultData.coin!.ethereum!),
                      formatNumber(
                          list[3].price, resultData.coin!.ethereum! * 77),
                    ),
                    const Gap(10),
                    Expanded(
                      child: AllCoin(
                        coinsList: list,
                        currencyList: currencyList,
                        tickerList: tickerList,
                        wishlistCoinsList: wishlistCoinsList,
                        showWishlistAtFirst: false,
                        currencyTabSelectedItemColor: Colors.red,
                        currencyTabBackgroundColor: Colors.transparent,
                        currencyTabHeight: 100,
                        showHeading: true,
                        inrRate: 77.0,
                        onWishlistError: Center(
                          child: Text(
                            'Wishlist not found!!',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        onCoinTap: (ctx, coin) {},
                      ),
                    ),
                  ],
                );
              } else {
                debugPrint(snapshot.error.toString());
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsData.selectiveYellow,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
