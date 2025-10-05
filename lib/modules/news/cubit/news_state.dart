import 'package:news_app/api_manager/models/articles_model.dart';

abstract class NewsState {}

class InitStates extends NewsState{}
class GetNewsLoadingState extends NewsState{}
class GetNewsErrorState extends NewsState{
  String error;
  GetNewsErrorState(this.error);
}
class GetNewsSuccessState extends NewsState{
  List<Articles>articles;
  GetNewsSuccessState(this.articles);
}
class GetSourcesLoadingState extends NewsState{}
class GetSourcesErrorState extends NewsState{
  String error;
  GetSourcesErrorState(this.error);
}
class GetSourcesSuccessState extends NewsState{
  List<Source>sources;
  GetSourcesSuccessState(this.sources);
}