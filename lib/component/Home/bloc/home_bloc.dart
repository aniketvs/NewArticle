import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ezar/model/news_article_model.dart';
import 'package:ezar/repository/article_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String _page = "1";

  String get page => _page;
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_homeInitialEvent);
    on<HomeAddPageSizeEvent>(_homePageSizeEvent);
    on<HomeSearchEvent>(_homeSearchEvent);
  }

  FutureOr<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    Map<String, dynamic> param = {
      "category": event.category.toLowerCase() == "top headlines"
          ? ""
          : event.category.toLowerCase(),
      "pageSize": "15",
      "page": page,
      "country": "in",
      "apiKey": "792be537534a4bfea2b9cfbe920a1c7a"
    };
    NewsArticleModel res = await ArticleRepoSitory.getNewsArticle(param);
    if (res.status == "ok" && res.totalResults! > 0) {
      List<Articlesmodle> article = state.articles ?? [];
      article.addAll(res.articles!);

      emit(HomeSuccessState(articles: article));
    } else {
      emit(HomeErrorState());
    }
    print("bloc ${state.articles}");
  }

  FutureOr<void> _homePageSizeEvent(
      HomeAddPageSizeEvent event, Emitter<HomeState> emit) {
    _page = (int.parse(page) + 1).toString();
  }

  FutureOr<void> _homeSearchEvent(
      HomeSearchEvent event, Emitter<HomeState> emit) async {
        emit(HomeSearchLoadingState(articles: state.articles ?? []));
    Map<String, dynamic> param = {
      "q": event.query.toLowerCase(),
      "pageSize": "15",
      "page": page,
      "apiKey": "792be537534a4bfea2b9cfbe920a1c7a"
    };
    NewsArticleModel res = await ArticleRepoSitory.getSearchApi(param);
    if (res.status == "ok" && res.totalResults! > 0) {
      emit(HomeSuccessState(articles: res.articles));
    } else {
      emit(HomeErrorState());
    }
  }
}
