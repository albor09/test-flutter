import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestvpn_test/feature/news/model/article.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({required this.artilce, super.key});

  final Article artilce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
              title: Text(
                artilce.title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              shape: const ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              expandedHeight: MediaQuery.of(context).size.height / 2,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Colors.black,
              stretch: true,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(artilce.imageUrl),
                                fit: BoxFit.cover)),
                      ),
                      Positioned.fill(
                          child: Container(
                        color: Colors.black.withOpacity(0.7),
                      )),
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.only(left: 32),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            artilce.title,
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(artilce.description ?? ''),
            ),
          )
        ],
      ),
    );
  }
}
