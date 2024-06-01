import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forestvpn_test/feature/news/data/abstract_news_repository.dart';
import 'package:forestvpn_test/feature/news/model/article.dart';

class FeaturedNewsBloc extends Bloc<FeaturedNewsEvent, FeaturedNewsState> {
  FeaturedNewsBloc({required AbstractNewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(const FeaturedNewsState.initial()) {
    on<FeaturedNewsEvent>((event, emit) => switch (event) {
          _LoadNewsEvent() => _loadNews(event, emit),
          _ReadAllNewsEvent() => _readAllNew(event, emit),
        });
  }

  final AbstractNewsRepository _newsRepository;

  Future<void> _loadNews(_LoadNewsEvent event, Emitter emit) async {
    emit(const FeaturedNewsState.loading());
    var data = await _newsRepository.getFeaturedArticles();
    emit(FeaturedNewsState.loaded(articles: data));
  }

  Future<void> _readAllNew(_ReadAllNewsEvent event, Emitter emit) async {
    emit(FeaturedNewsState.loaded(
        articles:
            state.articles.map((x) => x.copyWith(readed: true)).toList()));
  }
}

sealed class FeaturedNewsState {
  const FeaturedNewsState();

  List<Article> get articles => switch (this) {
        _NewsStateLoaded(articles: List<Article> articles) => articles,
        _ => []
      };

  bool get isLoading =>
      switch (this) { _NewsStateLoading() => true, _ => false };

  const factory FeaturedNewsState.initial() = _NewsStateInitial;

  const factory FeaturedNewsState.loading() = _NewsStateLoading;

  const factory FeaturedNewsState.loaded({required List<Article> articles}) =
      _NewsStateLoaded;

  const factory FeaturedNewsState.error(
      {required String message,
      required List<Article> articles}) = _NewsStateError;
}

final class _NewsStateInitial extends FeaturedNewsState {
  const _NewsStateInitial();
}

final class _NewsStateLoading extends FeaturedNewsState {
  const _NewsStateLoading();
}

final class _NewsStateLoaded extends FeaturedNewsState {
  final List<Article> articles;

  const _NewsStateLoaded({required this.articles});
}

final class _NewsStateError extends FeaturedNewsState {
  final String message;
  final List<Article> articles;

  const _NewsStateError({required this.message, required this.articles});
}

sealed class FeaturedNewsEvent {
  const FeaturedNewsEvent();

  const factory FeaturedNewsEvent.loadNews() = _LoadNewsEvent;
  const factory FeaturedNewsEvent.readAllNews() = _ReadAllNewsEvent;
}

final class _LoadNewsEvent extends FeaturedNewsEvent {
  const _LoadNewsEvent();
}

final class _ReadAllNewsEvent extends FeaturedNewsEvent {
  const _ReadAllNewsEvent();
}
