part of 'ticker_details_cubit.dart';

sealed class TickerDetailsState extends Equatable {
  const TickerDetailsState();

  @override
  List<Object> get props => [];
}

class LoadingTickerDetailsState extends TickerDetailsState {
  const LoadingTickerDetailsState();
}

class LoadedTickerDetailsState extends TickerDetailsState {
  final List<TickerArticle> news;

  const LoadedTickerDetailsState({
    required this.news,
  });
  @override
  List<Object> get props => [news];
}

class ErrorTickerDetailsState extends TickerDetailsState {
  final dynamic error;
  const ErrorTickerDetailsState({required this.error});
}
