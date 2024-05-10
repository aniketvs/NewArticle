part of 'home_bloc.dart';

@immutable
sealed class HomeState {
    List<Articlesmodle>? articles;
  HomeState({this.articles});
}

sealed class HomeActionState extends HomeState {

}

final class HomeInitial extends HomeState {}

final class HomeSuccessState extends HomeState {
  HomeSuccessState({required super.articles});
}

final class HomeErrorState extends HomeActionState {}
