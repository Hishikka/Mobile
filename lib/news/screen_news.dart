import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:projects/news/news_view.dart';
import 'package:projects/news/service.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final Widget title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Article> future;

  @override
  void initState() async{
     future = await getNewsData();

     super.initState();
  }


  Widget buildNewsItem(Article article) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NewsWebView(url: article.url!, title: article.title!),
            ));
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  article.urlToImage ?? "",
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title!,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        article.source.name!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewsListView(List<Article> articleList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Article article = articleList[index];
        return buildNewsItem(article);
      },
      itemCount: articleList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Align(
          alignment: Alignment.center,
          child: widget.title,
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Во время загрузки возникла ошибка!"),
                      );
                    } else {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return buildNewsListView(snapshot.data as List<Article>);
                      } else {
                        return const Center(
                          child: Text("Нет доступных новостей!"),
                        );
                      }
                    }
                  },
                  future: future,
                ),
              )
            ],
          )),
    );
  }
}
