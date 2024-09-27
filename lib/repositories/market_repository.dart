import 'package:market_bloc/services/market_service.dart';

class MarketRepository {
  final MarketService marketApiServices;

  MarketRepository({required this.marketApiServices});

  Future<dynamic> fetchCurrentData() async {
    try {
      // final dynamic currentData = await marketApiServices.getCurrentData();
      // print('currentData: $currentData');

      final dynamic tickersData = await marketApiServices.getTickersData();
      print('tickersData: $tickersData');
      return tickersData;
    } catch (e) {
      print(e);
    }
  }
}
