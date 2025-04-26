part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final List<MovieModel> moviesList;
  final bool isGrid;
  final Tabs tab;
  final LoadStatus loadStatus;
  final List<GenreModel> genreList;
  final TextEditingController? searchController;
  final ScrollController? scrollController;
  final int? page;
  final int? totalPage;

  const HomeState({
    this.moviesList = const [],
    this.isGrid = false,
    this.tab = Tabs.upcoming,
    this.loadStatus = LoadStatus.initial,
    this.genreList = const [],
    this.searchController,
    this.scrollController,
    this.page = 1,
    this.totalPage = 1,
  });

  HomeState copyWith({
    List<MovieModel>? moviesList,
    bool? isGrid,
    Tabs? tab,
    LoadStatus? loadStatus,
    List<GenreModel>? genreList,
    TextEditingController? searchController,
    ScrollController? scrollController,
    int? page,
    int? totalPage,
  }) {
    return HomeState(
      moviesList: moviesList ?? this.moviesList,
      isGrid: isGrid ?? this.isGrid,
      tab: tab ?? this.tab,
      loadStatus: loadStatus ?? this.loadStatus,
      genreList: genreList ?? this.genreList,
      searchController: searchController ?? this.searchController,
      scrollController: scrollController ?? this.scrollController,
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [
    moviesList,
    isGrid,
    tab,
    loadStatus,
    genreList,
    searchController,
    scrollController,
    page,
    totalPage,
  ];
}
