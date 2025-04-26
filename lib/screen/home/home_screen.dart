import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/screen/home/model/genre/genre_model.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/enum/tabs.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../utils/cached_network_image.dart';
import '../../utils/enum/loading_status.dart';
import '../../utils/search_field.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        minimum: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.loadStatus == LoadStatus.loading ,
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: List.generate(
                            Tabs.values.length,
                            (i){
                              return Expanded(
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: (){
                                    if(state.tab != Tabs.values[i]){
                                      context.read<HomeBloc>().add(OnTabSwitch(tabs: Tabs.values[i], isNew: true));
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                     color: state.tab == Tabs.values[i] ? Colors.amber : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: state.tab != Tabs.values[i] ?  Border.all(
                                        color: Colors.amber
                                      ) : null
                                    ),
                                    child: Text(Tabs.values[i].value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: state.tab == Tabs.values[i] ? Colors.black : Colors.white
                                    ),
                                    textAlign: TextAlign.center,),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),

                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: AppSearchField(
                            controller: state.searchController!,
                            hintText: 'Search movies...',
                            onChanged: (value) {
                              print('Searching for: $value');
                            },
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              context.read<HomeBloc>().add(const SwitchList());
                            },
                            child: Icon(!state.isGrid ? Icons.list : Icons.grid_on,
                            color: Colors.white,)
                        ),
                      ],
                    ),

                   state.moviesList.isNotEmpty ? Expanded(
                      child: state.isGrid ?  listView(state) :
                      gridView(state),
                    ) :
                   Expanded(
                     child: Center(
                       child: Text("No result found",
                         style: TextStyle(fontWeight: FontWeight.w300,
                             fontSize: 18,
                             color: Colors.white),
                       ),
                     ),
                   ),

                  ],
                ),
              );
            },
          )
      ),
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return FloatingActionButton(
          onPressed: (){
            showGenreBottomSheet(
              context: context,
              genres: state.genreList,
              selectedGenres: state.genreList.where((e)=>e.isSelected ?? false).toList(),
              onGenreTap: (selected) {
                context.read<HomeBloc>().add(GenreTap(index: state.genreList.indexWhere((t)=>t.id == selected.id)));
              },
              onApplyFilter: () {
                context.read<HomeBloc>().add(ApplyFilter());
              },
              onClearFilter: () {
                context.read<HomeBloc>().add(ClearFilter());
              },
            );
          },
           backgroundColor: Colors.amber,
        shape: const CircleBorder(),
              child: Icon(Icons.filter_alt,color: Colors.black,),
      );
  },
),
    );
  }

  Widget gridView(HomeState state) {
    return GridView.builder(
                      itemCount: state.moviesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 2 / 3, // for poster-like aspect
                      ),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            AppCachedImage(
                              imageUrl: getTmdbImageUrl(state.moviesList[index].posterPath),
                              borderRadius: BorderRadius.circular(12),
                            ),

                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.black.withOpacity(0.5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          state.moviesList[index].title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                DateFormat('MMMM d, y').format(state.moviesList[index].releaseDate),
                                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                                              ),
                                            ),
                                            Row(
                                              spacing: 2,
                                              children: [
                                                const Icon(Icons.star, color: Colors.amber, size: 14),
                                                Text(
                                                  state.moviesList[index].voteCount.toString(),
                                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        );
                      },
                    );
  }

  Widget listView(HomeState state) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      controller: state.scrollController,
      padding: const EdgeInsets.only(bottom: 10),
      itemCount: state.loadStatus == LoadStatus.loadingMore
          ? state.moviesList.length + 1
          : state.moviesList.length,

      itemBuilder: (BuildContext context, int index) {
        if (state.loadStatus == LoadStatus.loadingMore &&
            index == state.moviesList.length) {
          return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ));
        } else{
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCachedImage(
                  imageUrl: getTmdbImageUrl(state.moviesList[index].posterPath),
                  height: 140,
                  width: 100,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(10),
                ),
                Expanded(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(state.moviesList[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),),
                          ),
                          Text("${state.moviesList[index].voteAverage}",
                            style: TextStyle(fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Text(state.moviesList[index].overview,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        maxLines: 4,),

                      Text(DateFormat('MMMM d, y').format(
                          state.moviesList[index].releaseDate),
                        style: TextStyle(color: Colors.white, fontSize: 12),),


                    ],
                  ),
                )
              ],
            ),
          );
        }

      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 15,);
      },

    );
  }
}
String getTmdbImageUrl(String path, {String size = "w500"}) {
  return "https://image.tmdb.org/t/p/$size$path";
}

void showGenreBottomSheet({
  required BuildContext context,
  required List<GenreModel> genres,
  required List<GenreModel> selectedGenres,
  required void Function() onApplyFilter,
  required void Function() onClearFilter,
  required void Function(GenreModel) onGenreTap,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      List<GenreModel> tempSelected = List.from(selectedGenres);
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Genres",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    primary: false,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 15,
                      children: genres.map((genre) {
                        final isSelected = tempSelected.contains(genre);
                        return InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: (){
                            onGenreTap.call(genre);
                            if(tempSelected.contains(genre)){
                              tempSelected.remove(genre);
                            }else{
                              tempSelected.add(genre);
                            }
                            setState((){});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                            decoration: BoxDecoration(
                                color: isSelected ? Colors.amber : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: !isSelected ?  Border.all(
                                    color: Colors.amber
                                ) : null
                            ),
                            child: Text(genre.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:isSelected ? Colors.black : Colors.white
                              ),
                              textAlign: TextAlign.center,),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.transparent), // optional: white background
                          foregroundColor: WidgetStateProperty.all(Colors.transparent), // optional: black text
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // optional: rounded corners
                              side: const BorderSide(
                                color: Colors.amber, // border color
                                width: 1.5, // border thickness
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          onClearFilter.call();
                          Navigator.pop(context);
                        },
                        child:  Text("Clear",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.amber),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // optional: rounded corners
                            ),
                          ),
                        ),
                        onPressed: () {
                          onApplyFilter.call();
                          Navigator.pop(context);
                        },
                        child:  Text("Apply",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    },
  );
}
