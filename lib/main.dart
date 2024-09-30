import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:market_bloc/cubits/cubit/market_cubit.dart';
import 'package:market_bloc/repositories/market_repository.dart';
import 'package:market_bloc/screens/ticker_details_screen.dart';
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
    return RepositoryProvider(
      create: (context) => MarketRepository(
          marketApiServices: MarketService(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => MarketCubit(context.read())..fetchData())
        ],
        child: BlocBuilder<MarketCubit, MarketState>(
          builder: (context, state) {
            return switch (state) {
              ErrorMarketState() => Text('Error: ${state.error}'),
              LoadingMarketState() =>
                const Center(child: CircularProgressIndicator()),
              LoadedMarketState() => MaterialApp(
                  title: 'Market app',
                  theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                  ),
                  home: MyHomePage(title: 'Market app', state: state),
                )
            };
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final LoadedMarketState state;
  const MyHomePage({super.key, required this.title, required this.state});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: state.tickers.tickers.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: TickerItem(
                tickerName: state.tickers.tickers[index].name,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TickerDEtailsScreen(
                      ticker: state.tickers.tickers[index].name,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

enum ButtonState {
  enabled,
  disabled,
}
