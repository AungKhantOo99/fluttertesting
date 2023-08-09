import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'all_movies_bloc.dart';
import 'all_movies_event.dart';
import 'all_movies_state.dart';

class AllMoviesPage extends StatelessWidget {
  const AllMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int page=2;
    return  CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            // Handle leading icon tap
          },
          child: Icon(CupertinoIcons.bars), // Your custom leading icon
        ),
        middle: Text('Cupertino App'),
      ),

      child: BlocBuilder<AllMoviesBloc, AllMoviesState>(
        builder: (context, state) {
          if(state is AllMoviesLoaded){
            return ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CachedNetworkImage(
                          fit:  BoxFit.fitHeight,
                          imageUrl:
                          "https://image.tmdb.org/t/p/w500${state.data[index].posterPath}",
                          errorWidget: (context, url, error) =>
                               Image.network(""),
                        ),
                      Text(state.data[index].title!,style: GoogleFonts.adamina(fontSize: 16)),
                      ],
                    );
                  },
                ),
                ElevatedButton(onPressed: (){
                  context.read<AllMoviesBloc>().add(Reload(page));
                  page++;
                }, child: const Text("Reload")),
              ],
            );
          }else if(state is AllMoviesLoading){
            return  const Center(child: CupertinoActivityIndicator()
            );
          }else if(state is AllMoviesError){
            return  Column(
              children: [
                 Center(
                    child: Text(state.wrong)),
                Center(
                  child:ElevatedButton(onPressed: (){
                    context.read<AllMoviesBloc>().add(InitEvent());
                    page++;
                  }, child: const Text("Reload")),),
              ],
            );
          }else{
            return const Text("Null");
          }
        },
      ),
    );
  }
}
