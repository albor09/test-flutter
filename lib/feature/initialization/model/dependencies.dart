import 'package:forestvpn_test/feature/news/bloc/featured_news_bloc.dart';
import 'package:forestvpn_test/feature/news/data/abstract_news_repository.dart';

class Dependencies {
  final AbstractNewsRepository newsRepository;

  final FeaturedNewsBloc featuredNewsBloc;

  Dependencies({required this.newsRepository, required this.featuredNewsBloc});
}
