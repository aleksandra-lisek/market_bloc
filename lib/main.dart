import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:market_bloc/cubits/cubit/ticker_details_cubit.dart';
import 'package:market_bloc/cubits/market/market_cubit.dart';
import 'package:market_bloc/repositories/market_repository.dart';
import 'package:market_bloc/screens/ticker_details_screen.dart';
import 'package:market_bloc/services/market_service.dart';

import 'package:market_bloc/widgets/ticker_item.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'details',
          path: 'details/:ticker',
          builder: (BuildContext context, GoRouterState state) {
            return TickerDetailsScreen(
              ticker: state.pathParameters['ticker'] ?? '',
            );
          },
        ),
      ],
    ),
  ],
);
void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

/// The main app.
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
            create: (context) => MarketCubit(context.read())..fetchData(),
          ),
          BlocProvider(
            create: (context) => TickerDetailsCubit(context.read()),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketCubit, MarketState>(builder: (context, state) {
      return switch (state) {
        ErrorMarketState() => Text('Error: ${state.error}'),
        LoadingMarketState() =>
          const Center(child: CircularProgressIndicator()),
        LoadedMarketState() => MyHomePage(state: state),
      };
    });
  }
}

class MyHomePage extends StatelessWidget {
  final LoadedMarketState state;
  const MyHomePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Market App"),
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
                  onTap: () => context.goNamed('details', pathParameters: {
                        'ticker': state.tickers.tickers[index].ticker
                      })),
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
