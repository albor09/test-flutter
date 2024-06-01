import 'package:flutter/widgets.dart';
import 'package:forestvpn_test/feature/initialization/model/dependencies.dart';
import 'package:forestvpn_test/feature/news/bloc/featured_news_bloc.dart';
import 'package:forestvpn_test/feature/news/data/abstract_news_repository.dart';
import 'package:forestvpn_test/feature/news/data/mock_news_repository.dart';
import 'package:forestvpn_test/main.dart';

class Initializer {
  void run() {
    AbstractNewsRepository newsRepository = MockNewsRepository();
    FeaturedNewsBloc featuredNewsBloc =
        FeaturedNewsBloc(newsRepository: newsRepository);
    runApp(ForestVPNTestApp(
      dependencies: Dependencies(
          newsRepository: newsRepository, featuredNewsBloc: featuredNewsBloc),
    ));
  }
}
