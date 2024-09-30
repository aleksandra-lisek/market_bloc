// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:market_bloc/constants/services.dart';
import 'package:market_bloc/models/market.dart';

class MarketService {
  final http.Client httpClient;
  MarketService({
    required this.httpClient,
  });

  Future<Tickers> getTickersData() async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kApiHost,
        path: '/v3/reference/tickers/',
        queryParameters: {
          'active': 'true',
          'limit': '20',
          'apiKey': dotenv.env['APPID'],
        });

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        // throw Error();
        final responseBody = json.decode(response.body);

        print(responseBody['error']);
      }
      final responseBody = json.decode(response.body);
      final listOfTickers = Tickers.fromJson(responseBody);

      return listOfTickers;
    } catch (e) {
      rethrow;
    }
  }

  Future<TickerDetail> getTickerDetailsData(String ticker) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kApiHost,
        path: '/v3/reference/tickers/',
        queryParameters: {
          'ticker': ticker,
        });

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        // throw Error();
        final responseBody = json.decode(response.body);

        print(responseBody['error']);
      }
      final responseBody = json.decode(response.body);
      final listOfTickers = TickerDetail.fromJson(responseBody);

      return listOfTickers;
    } catch (e) {
      rethrow;
    }
  }
}
