import 'package:equatable/equatable.dart';

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
  @override
  List<Object> get props => [tickers];
}

class TickerNews extends Equatable {
  final List<TickerArticle> news;

  const TickerNews({required this.news});

  @override
  List<Object> get props => [news];

  factory TickerNews.fromJson(Map<String, dynamic> json) {
    final List<dynamic> tickersNews = json["results"];

    return TickerNews(
      news: tickersNews
          .map(
            (e) => TickerArticle(
              title: e['title'],
              author: e['author'],
              description: e['description'],
              imageUrl: e['image_url'],
              articleUrl: e['article_url'],
            ),
          )
          .toList(),
    );
  }
}

class TickerArticle extends Equatable {
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String articleUrl;

  const TickerArticle({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.articleUrl,
  });

  @override
  List<Object> get props => [title, author, description, imageUrl, articleUrl];

  TickerArticle copyWith({
    String? title,
    String? author,
    String? description,
    String? imageUrl,
    String? articleUrl,
  }) {
    return TickerArticle(
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      articleUrl: articleUrl ?? this.articleUrl,
    );
  }
}
