import 'package:ezar/api/api_service.dart';
import 'package:ezar/model/news_article_model.dart';

class ArticleRepoSitory {
  static Future<NewsArticleModel> getNewsArticle(param)async{
NewsArticleModel response=await ApiService.getNews(param);
int len=int.parse(response.totalResults.toString());
print("llllllllllllrrrrrrrrr $response");
if(response.status=='ok' && len>0){
return response;
}else{
  return NewsArticleModel();
}
  }
}