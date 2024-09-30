import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:market_bloc/models/market.dart';
import 'package:market_bloc/repositories/market_repository.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final MarketRepository _marketRepository;
  MarketCubit(this._marketRepository) : super(const LoadingMarketState());

  Future<void> fetchData() async {
    try {
      final Tickers tickers = await _marketRepository.fetchTickersData();
      emit(LoadedMarketState(tickers: tickers));
    } catch (e) {
      emit(ErrorMarketState(error: e));
    }
  }
}
