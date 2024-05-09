part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final String category;
  final String pageSize;
  HomeInitialEvent(this.category,this.pageSize);
 
}
class  HomeAddPageSizeEvent extends HomeEvent{}