// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}

class ErrorTickerDetailsState extends TickerDetailsState {
  final dynamic error;
  const ErrorTickerDetailsState({required this.error});
}
