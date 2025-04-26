import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/repository/remote/remote_repo.dart';

import '../../../api_service/failure_response.dart';
import '../../../repository/local/local_repo.dart';
import '../../../utils/enum/loading_status.dart';
import '../../../utils/enum/tabs.dart';
import '../model/genre/genre_model.dart';
import '../model/movie/movie_model.dart';

part 'home_event.dart';
part 'home_state.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  RemoteRepo remoteRepo;
  LocalRepo localRepo;

  HomeBloc({required this.localRepo,required this.remoteRepo}) : super(HomeState(
    scrollController: ScrollController()
  )) {


    state.scrollController?.addListener(
            () {
          var nextPageTrigger = state.scrollController!.position.maxScrollExtent;

          if (state.scrollController!.position.pixels == nextPageTrigger &&
              state.page! <= state.totalPage! &&
              state.loadStatus != LoadStatus.loadingMore) {
            add(OnTabSwitch(tabs: state.tab));
          }
        }
    );

    on<SwitchList>((event, emit) {
      emit(state.copyWith(isGrid: !state.isGrid));
    });

    on<OnTabSwitch>((event, emit) async {
      if (state.page == 1) {
        emit(state.copyWith(loadStatus: LoadStatus.loading,moviesList: MovieModel.getDummyList()));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.loadingMore));
      }

      Either<FailureResponse, Map<String, dynamic>>? res ;

      if(event.tabs == Tabs.upcoming){
        res =  await remoteRepo.getTopUpcomingMovies(param: {"page" : state.page});
      } else if(event.tabs == Tabs.topRated){
        res = await remoteRepo.getTopRatedMovies(param: {"page" : state.page});
      }else{
        res =  await remoteRepo.getPopularMovies(param: {"page" : state.page});
      }


      if(res!=null){
        res.fold(
                (l){
                  emit(state.copyWith(loadStatus: LoadStatus.failure));
                }, (r){

                  print("kasim");
                  print(r);
                  List data = r['response']['results'];

                  List<MovieModel> list = [];


                  list = List.from(data.map((e)=>MovieModel.fromJson(e)).toList());

                  if (state.page != 1) {
                    List<MovieModel> movies = state.moviesList.toList();
                    list.addAll(movies);
                  }

                  emit(state.copyWith(moviesList: list,loadStatus: LoadStatus.success,totalPage: r['response']['total_results']));

        }
        );

      }


    });

    on<FetchGenre>((event, emit) async {

      Either<FailureResponse, Map<String, dynamic>>? res =  await remoteRepo.getGenre();

      if(res !=null){
        res.fold((l){

        }, (r){
          List<GenreModel> genres = List.from(r['response']['genres'].map((e)=>GenreModel.fromJson(e)).toList());
          emit(state.copyWith(genreList: genres));
        }
        );
      }



    });

  }
}
