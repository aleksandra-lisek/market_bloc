import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:market_bloc/models/market.dart';
import 'package:market_bloc/repositories/market_repository.dart';
import 'package:market_bloc/services/market_service.dart';

import 'package:market_bloc/widgets/ticker_item.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ButtonState {
  enabled,
  disabled,
}

class _MyHomePageState extends State<MyHomePage> {
  Tickers tickers = const Tickers(
    tickers: [
      Ticker(name: 'Microsoft Corporation', ticker: 'MSFT'),
      Ticker(name: 'Apple Inc', ticker: 'AAPL'),
      Ticker(name: 'Amazon.com Inc', ticker: 'AMZN'),
      Ticker(name: 'Alphabet Inc - Class C', ticker: 'GOOG'),
      Ticker(name: 'Alphabet Inc - Class A', ticker: 'GOOGL'),
      Ticker(name: 'Alibaba Group Holding Ltd', ticker: 'BABA'),
      Ticker(name: 'Meta Platforms Inc - Class A', ticker: 'FB'),
      Ticker(name: 'BERKSHIRE HATHAWAY INC', ticker: 'BRK.B'),
      Ticker(name: 'BERKSHIRE HATHAWAY INC', ticker: 'BRK.A'),
      Ticker(name: 'Vodafone Group plc', ticker: 'VOD'),
      Ticker(name: 'Visa Inc - Class A', ticker: 'V'),
      Ticker(name: 'JPMorgan Chase & Company', ticker: 'JPM'),
      Ticker(name: 'Johnson & Johnson', ticker: 'JNJ'),
      Ticker(name: ' Walmart Inc', ticker: 'WMT'),
      Ticker(name: 'Mastercard Incorporated - Class A', ticker: 'MA'),
      Ticker(name: 'Procter & Gamble Company', ticker: 'PG'),
      Ticker(name: 'Taiwan Semiconductor Manufacturing', ticker: 'TSM'),
      Ticker(name: 'Chunghwa Telecom', ticker: 'CHT'),
      Ticker(name: 'Roche Holding AG', ticker: 'RHHBF')
    ],
  );

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    MarketRepository(
            marketApiServices: MarketService(httpClient: http.Client()))
        .fetchCurrentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
            padding: const EdgeInsets.all(24),
            child: ListView.builder(
              itemCount: tickers.tickers.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TickerItem(
                      tickerName: tickers.tickers[index].name,
                    ));
              },
            )));
  }
}
