// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:market_bloc/cubits/cubit/ticker_details_cubit.dart';
import 'package:market_bloc/utils/hex_color.dart';
import 'package:url_launcher/url_launcher.dart';

class TickerDetailsScreen extends StatefulWidget {
  final String ticker;
  const TickerDetailsScreen({super.key, required this.ticker});

  @override
  State<TickerDetailsScreen> createState() => _TickerDetailsScreenState();
}

class _TickerDetailsScreenState extends State<TickerDetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData(widget.ticker);
  }

  void _fetchData(String ticker) {
    context.read<TickerDetailsCubit>().fetchData(ticker);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TickerDetailsCubit, TickerDetailsState>(
      builder: (context, state) {
        return switch (state) {
          LoadedTickerDetailsState() => _Details(state: state),
          LoadingTickerDetailsState() =>
            const Center(child: CircularProgressIndicator()),
          ErrorTickerDetailsState() => Text('Error: ${state.error}'),
        };
      },
    );
  }
}

class _Details extends StatelessWidget {
  final LoadedTickerDetailsState state;

  const _Details({
    required this.state,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('news'),
        leading: const CloseButton(),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: state.news.length,
          itemBuilder: (BuildContext context, int index) {
            final item = state.news[index];

            return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network(item.imageUrl),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18,
                              color: HexColor('1E1E1E'),
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: HexColor('575151'),
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.author,
                            style: TextStyle(
                              fontSize: 8,
                              color: HexColor('575151'),
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ))),
                              onPressed: () {
                                launchUrl(Uri.parse(item.articleUrl));
                              },
                              child: const Text('Go to an article')),
                        ])));
          },
        ),
      ),
    );
  }
}
