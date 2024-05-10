part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final String category;
  
  HomeInitialEvent(this.category);
 
}
class HomeSearchEvent extends HomeEvent {
  final String query;
  
  HomeSearchEvent(this.query);
 
}
class  HomeAddPageSizeEvent extends HomeEvent{}