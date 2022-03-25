import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dailybook/services/apiservice.dart';
import 'package:equatable/equatable.dart';

import '../../models/article_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService newsService;

  NewsBloc(this.newsService) : super(NewsInitial()) {
    on<InitNewsEvent>((event, emit) async{
      final Article articles = await newsService.fetchArticles();
      emit(InitNewsState(articles));
    });
  }
}
