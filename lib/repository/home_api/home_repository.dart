import 'package:api_provider_016/model/newsmodel.dart';

abstract class HomeRepository {
  Future<NewsModel> fetchNewsList(String url); // Add parameter here
}
