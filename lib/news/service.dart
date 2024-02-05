import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';



Future<List<Article>> getNewsData() async {
  NewsAPI newsAPI = NewsAPI("176ed657fdd541eba9b9c02df088ba1d");
  return await newsAPI.getEverything(
    query: "Apple",
    pageSize: 10,
  );
}
