import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api_manager/models/articles_model.dart';
import 'package:news_app/modules/news/cubit/news_state.dart';

import '../../../api_manager/api_manager.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit():super(InitStates());
  Future<void> getNews(String source) async {
    emit(GetNewsLoadingState());
    try{
      List<Articles> articles = await ApiManager.getNews(source);
      emit(GetNewsSuccessState(articles));
    }catch(e){
      emit(GetNewsErrorState(e.toString()));
    }
  }
  Future<void> getSources(String id) async {
    emit(GetNewsLoadingState());
    try{
      List<Source> sources = await ApiManager.getSources(id);
      emit(GetSourcesSuccessState(sources));
      getNews(sources[0].id??"");
    }catch(e){
      emit(GetSourcesErrorState(e.toString()));
    }
  }
}