part of 'home_bloc.dart';

@immutable
sealed class HomeState {
    List<Articlesmodle>? articles;
  HomeState({this.articles});
}

sealed class HomeActionState extends HomeState {

}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {
  HomeLoadingState({required super.articles});
}
final class HomeLoadingMoreDataState extends HomeState{
  HomeLoadingMoreDataState({required super.articles});
}
final class HomeSuccessState extends HomeState {
  HomeSuccessState({required super.articles});
}

final class HomeErrorState extends HomeActionState {}
