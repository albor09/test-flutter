import 'package:flutter/material.dart';
import 'package:forestvpn_test/core/extensions/date_time_extension.dart';
import 'package:forestvpn_test/feature/news/model/article.dart';
import 'package:forestvpn_test/feature/news/widget/article_screen.dart';
import 'package:forestvpn_test/feature/news/widget/featured_news_list.dart';
import 'package:forestvpn_test/feature/news/widget/featured_news_scope.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final articles = FeaturedNewsScope.of(context, listen: true).articles;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                FeaturedNewsScope.of(context).readAllArticles();
              },
              child: const Text(
                "Mark all read",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _Title(text: 'Featured'),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 8,
            ),
          ),
          SliverPersistentHeader(
              delegate: FeaturedNewsList(context, articles: articles)),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 8,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _Title(text: 'Latest news'),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 8,
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.separated(
                itemCount: articles.length,
                itemBuilder: (context, index) =>
                    _LatesNewsItem(article: articles[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
              )),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 8,
            ),
          )
        ],
      )),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.text, Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      );
}

class _LatesNewsItem extends StatelessWidget {
  const _LatesNewsItem({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FeaturedNewsScope.of(context).readArticle(article.id);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArticleScreen(artilce: article)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 100,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 4,
              spreadRadius: 2)
        ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    article.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(fontSize: 16, height: 1),
                    ),
                    const Spacer(),
                    Text(
                      article.publicationDate.timeAgo(),
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: article.readed ? Colors.transparent : Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
