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
        path: '/v1/tickers',
        queryParameters: {
          'access_key': dotenv.env['APPID'],
          'limit': '20'
          // 'symbols': symbols,
          // 'limit': '1'
        });

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Error();
      }
      final responseBody = json.decode(response.body);
      final listOfTickers = Tickers.fromJson(responseBody);
      print(listOfTickers);
      return listOfTickers;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

//   Future<dynamic> getCurrentData() async {
//     final Uri uri = Uri(
//       scheme: 'https',
//       host: kApiHost,
//       path: '/v1/eod',
//       queryParameters: {
//         'access_key': dotenv.env['APPID'],
//         'symbols': symbols,
//         // 'limit': '1'
//       },
//     );

//     try {
//       final http.Response response = await httpClient.get(uri);

//       if (response.statusCode != 200) {
//         throw Error();
//       }
//       final responseBody = json.decode(response.body);
//       print(responseBody);
//     } catch (e) {
//       print(e);
//     }
//   }
}
