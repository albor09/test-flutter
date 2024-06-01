import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forestvpn_test/feature/news/model/article.dart';

class FeaturedNewsList extends SliverPersistentHeaderDelegate {
  const FeaturedNewsList(this.context, {required this.articles});

  final BuildContext context;
  final List<Article> articles;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
        height: clampDouble(maxExtent - shrinkOffset, minExtent, maxExtent),
        child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: _FeaturedNewsItem(article: articles[index]),
                )));
  }

  @override
  double get maxExtent => 320;

  @override
  double get minExtent => 120; // height of latest news item + padding

  @override
  bool shouldRebuild(FeaturedNewsList oldDelegate) {
    return oldDelegate.articles != articles;
  }
}

class _FeaturedNewsItem extends StatelessWidget {
  const _FeaturedNewsItem({required this.article, Key? key}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 16 * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(article.imageUrl), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(2, 2),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ]),
            ),
          ),
          Positioned.fill(
              child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.7)),
          )),
          Positioned.fill(
              child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomLeft,
            child: Text(
              article.title,
              style: const TextStyle(fontSize: 26, color: Colors.white),
            ),
          ))
        ],
      ),
    );
  }
}
