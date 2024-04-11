import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/data/api_provider.dart';
import 'package:news_flutter/model/Article.dart';
import 'package:news_flutter/model/ArticleResponse.dart';
import 'package:news_flutter/ui/articledetailpage.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  HomePage({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FutureBuilder<ArticleResponse>(
          future: fetchTopHeadlines(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("${snapshot.error}");
            if (snapshot.hasData) {
              if (snapshot.data?.status == "ok") {
                return ArticleList(articles: snapshot.data?.articles ??[]);
              } else {
                return Text("${snapshot.data?.message ??""}");
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ArticleList extends StatelessWidget {
  final List<Article> articles;

  ArticleList({Key? key,required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        final item = articles[index];
        return Card(
          child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: item.urlToImage ?? "",
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                )),
            title: Text(
              item.title ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item.description ?? ""),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(
                  articleUrl: item.url ??'',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
