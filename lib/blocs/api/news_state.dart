part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class InitNewsState extends NewsState{
  final Article articles;

  InitNewsState(this.articles);

  @override
  // TODO: implement props
  List<Object?> get props => [articles];
}
