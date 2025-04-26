import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/repository/remote/remote_repo.dart';
import 'package:movie_app/utils/constants.dart';

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

  HomeBloc({required this.localRepo, required this.remoteRepo})
    : super(
        HomeState(
          scrollController: ScrollController(),
          searchController: TextEditingController(),
        ),
      ) {
    state.scrollController?.addListener(() {
      var nextPageTrigger = state.scrollController!.position.maxScrollExtent;

      if (state.scrollController!.position.pixels == nextPageTrigger &&
          state.page! <= state.totalPage! &&
          state.loadStatus != LoadStatus.loadingMore) {
        add(OnTabSwitch(tabs: state.tab, isNew: false));
      }
    });

    on<SwitchList>((event, emit) {
      emit(state.copyWith(isGrid: !state.isGrid));
    });

    on<GenreTap>((event, emit) {
      List<GenreModel> lists = state.genreList.toList();

      lists[event.index] = lists[event.index].copyWith(
        isSelected: !lists[event.index].isSelected!,
      );

      emit(state.copyWith(genreList: lists));
    });

    on<OnTabSwitch>((event, emit) async {
      if (event.isNew) {
        emit(state.copyWith(tab: event.tabs, page: 1, totalPage: 1));
      }

      if (state.page == 1) {
        emit(
          state.copyWith(
            loadStatus: LoadStatus.loading,
            moviesList: MovieModel.getDummyList(),
          ),
        );
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.loadingMore));
      }

      Either<FailureResponse, Map<String, dynamic>>? res;

      if (event.tabs == Tabs.upcoming) {
        res = await remoteRepo.getTopUpcomingMovies(
          param: {"page": state.page},
        );
      } else if (event.tabs == Tabs.topRated) {
        res = await remoteRepo.getTopRatedMovies(param: {"page": state.page});
      } else {
        res = await remoteRepo.getPopularMovies(param: {"page": state.page});
      }

      if (res != null) {
        await res.fold(
          (l) async {
            if (l.status) {
              List<MovieModel> movies = await localRepo.getMovies(
                type: event.tabs.name,
              );
              if (movies.isNotEmpty) {
                emit(
                  state.copyWith(
                    moviesList: movies,
                    primaryList: movies,
                    loadStatus: LoadStatus.success,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    loadStatus: LoadStatus.failure,
                    moviesList: movies,
                  ),
                );
              }
            } else {
              emit(
                state.copyWith(
                  failureResponse: l,
                  loadStatus: LoadStatus.success,
                  moviesList: [],
                ),
              );
            }
          },
          (r) {
            List data = r['response']['results'];

            List<MovieModel> list = [];

            list = List.from(data.map((e) => MovieModel.fromJson(e)).toList());
            List<MovieModel> movies = state.moviesList.toList();
            if (state.page != 1) {
              movies.addAll(list);
            } else {
              movies = list;
            }

            localRepo.setMovies(list: movies, type: event.tabs.name);

            emit(
              state.copyWith(
                moviesList: movies,
                primaryList: movies,
                loadStatus: LoadStatus.success,
                totalPage: r['response']['total_results'],
                page: state.page! + 1,
              ),
            );

            if (state.genreList.any((e) => e.isSelected!)) {
              add(ApplyFilter());
            } else if (state.searchController!.text.trim().isNotEmpty) {
              add(OnSearchMovie(movie: state.searchController!.text));
            }
          },
        );
      }
    });

    on<FetchGenre>((event, emit) async {
      Either<FailureResponse, Map<String, dynamic>>? res =
          await remoteRepo.getGenre();

      if (res != null) {
        await res.fold(
          (l) async {
            if (l.status) {
              List<GenreModel> movies = await localRepo.getGenre();
              emit(state.copyWith(genreList: movies));
            } else {
              emit(state.copyWith(failureResponse: l));
            }
          },
          (r) {
            List<GenreModel> genres = List.from(
              r['response']['genres']
                  .map((e) => GenreModel.fromJson(e))
                  .toList(),
            );

            localRepo.setGenre(list: genres);
            Constants.genresList = genres;
            emit(state.copyWith(genreList: genres));
          },
        );
      }
    });

    on<ClearFilter>((event, emit) {
      final filteredMovies = state.primaryList.toList();

      var genre =
          state.genreList.map((e) {
            e = e.copyWith(isSelected: false);
            return e;
          }).toList();

      emit(state.copyWith(moviesList: filteredMovies, genreList: genre));
    });

    on<ApplyFilter>((event, emit) {
      applyFiltersAndSearch(emit);
    });

    on<OnSearchMovie>((event, emit) {
      applyFiltersAndSearch(emit, searchQuery: event.movie);
    });

    on<Reset>((event, emit) {
      emit(state.copyWith(failureResponse: null));
    });
  }

  void applyFiltersAndSearch(Emitter<HomeState> emit, {String? searchQuery}) {
    List<MovieModel> filteredMovies = state.primaryList;

    final selectedGenres =
        state.genreList.where((e) => e.isSelected!).map((e) => e.id).toList();
    if (selectedGenres.isNotEmpty) {
      filteredMovies =
          filteredMovies.where((movie) {
            return movie.genreIds.any((id) => selectedGenres.contains(id));
          }).toList();
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      filteredMovies =
          filteredMovies.where((movie) {
            return movie.title.toLowerCase().contains(query);
          }).toList();
    }

    emit(state.copyWith(moviesList: filteredMovies));
  }
}
