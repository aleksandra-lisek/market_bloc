part of 'market_cubit.dart';

sealed class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object> get props => [];
}

class LoadingMarketState extends MarketState {
  const LoadingMarketState();
}

class LoadedMarketState extends MarketState {
  final Tickers tickers;
  const LoadedMarketState({
    required this.tickers,
  });

  LoadedMarketState copyWith({
    Tickers? tickers,
  }) {
    return LoadedMarketState(
      tickers: tickers ?? this.tickers,
    );
  }
}

class ErrorMarketState extends MarketState {
  final dynamic error;
  const ErrorMarketState({required this.error});
}
