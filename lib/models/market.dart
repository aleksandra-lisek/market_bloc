// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int limit;
  final int offset;
  final int count;
  final int total;
  const Pagination({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
  });
  factory Pagination.fromJson(Map<String, dynamic> json) {
    final pagination = json["pagination"];

    return Pagination(
        count: pagination['count'],
        limit: pagination['limit'],
        offset: pagination['offset'],
        total: pagination['total']);
  }
  @override
  String toString() {
    return 'Pagination(limit: $limit, offset: $offset, count: $count, total: $total)';
  }

  @override
  List<Object> get props => [limit, offset, count, total];
}

class Ticker extends Equatable {
  final String name;
  final String ticker;

  const Ticker({
    required this.name,
    required this.ticker,
  });
  factory Ticker.fromJson(Map<String, dynamic> json) {
    final ticker = json["data"];

    return Ticker(
      name: ticker['name'],
      ticker: ticker['ticker'],
    );
  }
  @override
  String toString() {
    return 'Ticker(name: $name, ticker: $ticker)';
  }

  @override
  List<Object> get props => [name, ticker];
}

class Tickers extends Equatable {
  final List<Ticker> tickers;

  const Tickers({
    required this.tickers,
  });
  factory Tickers.fromJson(Map<String, dynamic> json) {
    final List<dynamic> tickers = json["results"];

    return Tickers(
      tickers: tickers
          .map((e) => Ticker(name: e['name'], ticker: e['ticker']))
          .toList(),
    );
  }
  // @override
  // String toString() {
  //   return
  //   'Ticker(name: $name, symbol: $symbol)';
  // }

  @override
  List<Object> get props => [tickers];
}

// class MarketElement extends Equatable {
//   final int open;
//   final int high;
//   final int low;
//   const MarketElement({
//     required this.open,
//     required this.high,
//     required this.low,
//   });

//   @override
//   String toString() => 'MarketElement(open: $open, high: $high, low: $low)';

//   @override
//   List<Object> get props => [open, high, low];

//   MarketElement copyWith({
//     int? open,
//     int? high,
//     int? low,
//   }) {
//     return MarketElement(
//       open: open ?? this.open,
//       high: high ?? this.high,
//       low: low ?? this.low,
//     );
//   }
// }

// class Market extends Equatable {
//   final List<MarketElement> element;
//   const Market({
//     required this.element,
//   });
//   factory Market.fromJson(Map<String, dynamic> json) {
//     final List<Map> data = json["data"];
//     return Market(
//         element: data
//             .map((e) =>
//                 MarketElement(open: e["open"], high: e["high"], low: e["low"]))
//             .toList());
//   }
//   @override
//   String toString() =>
//       element.map((e) => 'Market(MarketElement: $e').toString();

//   @override
//   List<Object> get props => [element];

//   Market copyWith({
//     List<MarketElement>? element,
//   }) {
//     return Market(
//       element: element ?? this.element,
//     );
//   }
// }
