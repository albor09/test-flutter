import 'package:flutter/widgets.dart';
import 'package:forestvpn_test/core/extensions/context_extensions.dart';
import 'package:forestvpn_test/feature/initialization/widget/dependencies_scope.dart';
import 'package:forestvpn_test/feature/news/bloc/featured_news_bloc.dart';
import 'package:forestvpn_test/feature/news/model/article.dart';

class FeaturedNewsScope extends StatefulWidget {
  const FeaturedNewsScope({required this.child, super.key});

  final Widget child;

  static _FeaturedNewsScopeState of(BuildContext context,
          {bool listen = true}) =>
      context.inhOf<_FeaturedNewsInh>(listen: listen).scopeState;

  @override
  State<FeaturedNewsScope> createState() => _FeaturedNewsScopeState();
}

class _FeaturedNewsScopeState extends State<FeaturedNewsScope> {
  late final FeaturedNewsBloc _bloc;
  FeaturedNewsState state = const FeaturedNewsState.initial();

  @override
  void initState() {
    _bloc = DependenciesScope.of(context).featuredNewsBloc;
    _bloc.stream.listen((FeaturedNewsState state) {
      setState(() {
        this.state = state;
      });
    });
    loadNews();

    super.initState();
  }

  List<Article> get articles => state.articles;

  void loadNews() {
    _bloc.add(const FeaturedNewsEvent.loadNews());
  }

  void readAllArticles() {
    _bloc.add(const FeaturedNewsEvent.readAllArticles());
  }

  void readArticle(String id) {
    _bloc.add(FeaturedNewsEvent.readArticle(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return _FeaturedNewsInh(
        state: state, scopeState: this, child: widget.child);
  }
}

class _FeaturedNewsInh extends InheritedWidget {
  const _FeaturedNewsInh(
      {required this.state, required this.scopeState, required super.child});

  final FeaturedNewsState state;
  final _FeaturedNewsScopeState scopeState;

  @override
  bool updateShouldNotify(_FeaturedNewsInh oldWidget) =>
      oldWidget.state != state;
}
