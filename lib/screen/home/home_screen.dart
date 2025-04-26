import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../utils/enum/loading_status.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: Skeletonizer(
                      enabled: state.loadStatus == LoadStatus.loading ||
                          state.loadStatus == LoadStatus.failure,
                      child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: state.moviesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Column(
                              children: [
                                Text(state.moviesList[index].title)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 15,);
                          },

                      ),
                    ),
                  )

                ],
              );
            },
          )
      ),
    );
  }
}
