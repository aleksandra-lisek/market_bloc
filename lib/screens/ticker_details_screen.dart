import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_bloc/repositories/market_repository.dart';
import 'package:market_bloc/services/market_service.dart';

class TickerDEtailsScreen extends StatefulWidget {
  final String ticker;
  const TickerDEtailsScreen({super.key, required this.ticker});

  @override
  State<TickerDEtailsScreen> createState() => _TickerDEtailsScreenState();
}

class _TickerDEtailsScreenState extends State<TickerDEtailsScreen> {
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    MarketRepository(
            marketApiServices: MarketService(httpClient: http.Client()))
        .fetchTickersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.ticker),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Text(widget.ticker),
      ),
    );
  }
}
