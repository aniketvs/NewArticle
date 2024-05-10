import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ezar/model/news_article_model.dart';
import 'package:ezar/repository/article_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String _page="1";
  
  String get page => _page;
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_homeInitialEvent);
    on<HomeAddPageSizeEvent>(_homePageSizeEvent);
  }

  FutureOr<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
   
    Map<String, dynamic> param = {
      "category": event.category.toLowerCase() == "top headlines" ? "" : event.category.toLowerCase(),
      "pageSize": "15",
      "page":page,
      "country": "in",
      "apiKey": "c3d4857daefe40a7b8c1791977da161c"
    };
    NewsArticleModel res = await ArticleRepoSitory.getNewsArticle(param);
    if (res.status == "ok" && res.totalResults! > 0) {
     List<Articlesmodle> article=state.articles ?? [];
     article.addAll(res.articles!);
  
      emit(HomeSuccessState(articles:article));
    } else {
      emit(HomeErrorState());
    }
    print("bloc ${state.articles}");
  }

  FutureOr<void> _homePageSizeEvent(HomeAddPageSizeEvent event, Emitter<HomeState> emit) {
_page=(int.parse(page)+1).toString();
  }
}
