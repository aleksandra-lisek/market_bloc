import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:market_bloc/models/market.dart';
import 'package:market_bloc/repositories/market_repository.dart';

part 'ticker_details_state.dart';

class TickerDetailsCubit extends Cubit<TickerDetailsState> {
  final MarketRepository marketRepository;

  TickerDetailsCubit(this.marketRepository)
      : super(const LoadingTickerDetailsState());

  Future<void> fetchData(String ticker) async {
    emit(
      const LoadingTickerDetailsState(),
    );
    try {
      final TickerNews details =
          await marketRepository.fetchTickerDetailsData(ticker);
      emit(
        LoadedTickerDetailsState(
          news: details.news,
        ),
      );
    } catch (e) {
      emit(ErrorTickerDetailsState(error: e));
    }
  }
}
