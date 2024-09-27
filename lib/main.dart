import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:market_bloc/models/market.dart';
import 'package:market_bloc/repositories/market_repository.dart';
import 'package:market_bloc/services/market_service.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  Tickers tickers = const Tickers(
    tickers: [
      Ticker(name: 'Microsoft Corporation', symbol: 'MSFT'),
      Ticker(name: 'Apple Inc', symbol: 'AAPL'),
      Ticker(name: 'Amazon.com Inc', symbol: 'AMZN'),
      Ticker(name: 'Alphabet Inc - Class C', symbol: 'GOOG'),
      Ticker(name: 'Alphabet Inc - Class A', symbol: 'GOOGL'),
      Ticker(name: 'Alibaba Group Holding Ltd', symbol: 'BABA'),
      Ticker(name: 'Meta Platforms Inc - Class A', symbol: 'FB'),
      Ticker(name: 'BERKSHIRE HATHAWAY INC', symbol: 'BRK.B'),
      Ticker(name: 'BERKSHIRE HATHAWAY INC', symbol: 'BRK.A'),
      Ticker(name: 'Vodafone Group plc', symbol: 'VOD'),
      Ticker(name: 'Visa Inc - Class A', symbol: 'V'),
      Ticker(name: 'JPMorgan Chase & Company', symbol: 'JPM'),
      Ticker(name: 'Johnson & Johnson', symbol: 'JNJ'),
      Ticker(name: ' Walmart Inc', symbol: 'WMT'),
      Ticker(name: 'Mastercard Incorporated - Class A', symbol: 'MA'),
      Ticker(name: 'Procter & Gamble Company', symbol: 'PG'),
      Ticker(name: 'Taiwan Semiconductor Manufacturing', symbol: 'TSM'),
      Ticker(name: 'Chunghwa Telecom', symbol: 'CHT'),
      Ticker(name: 'Roche Holding AG', symbol: 'RHHBF')
    ],
  );

  @override
  void initState() {
    // _fetchData();
    super.initState();
  }

  // void _fetchData() {
  //   MarketRepository(
  //           marketApiServices: MarketService(httpClient: http.Client()))
  //       .fetchCurrentData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: ListView.builder(
          itemCount: tickers.tickers.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(tickers.tickers[index].name),
            );
          },
        )));
  }
}
