import 'package:market_bloc/models/market.dart';
import 'package:market_bloc/services/market_service.dart';

class MarketRepository {
  final MarketService marketApiServices;

  MarketRepository({required this.marketApiServices});

  Future<Tickers> fetchTickersData() async {
    try {
      final Tickers tickersData = await marketApiServices.getTickersData();

      return tickersData;
    } catch (e) {
      throw Error();
    }
  }

  Future<TickerNews> fetchTickerDetailsData(String ticker) async {
    try {
      final TickerNews tickersData =
          await marketApiServices.getTickerDetailsData(ticker);

      return tickersData;
    } catch (e) {
      throw Error();
    }
  }
}
