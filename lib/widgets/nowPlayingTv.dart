import 'package:flutter/material.dart';
import '../utils/text.dart';
import '../models/movies.dart';
import '../services/API_services.dart';
import '../screens/description.dart';


class NowPlayingTV extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(
          future: APIServices.getTopRatedTVShows(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final List<Movie> tv = snapshot.data!;
            return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              modified_text(
                text: 'Upcoming Movies',
                size: 26,
              ),
              SizedBox(height: 10),
              Container(
                  // color: Colors.red,
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tv.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          // color: Colors.green,
                          width: 250,
                          child: Column(
                            children: [
                              InkWell( onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Description(
                                            name: tv[index].title,
                                            bannerurl:'https://image.tmdb.org/t/p/w500' +
                                                tv[index].backdrop_path,
                                            description:
                                                tv[index].overview,
                                            launch_on:
                                                tv[index].release_date,
                                            posterurl:'https://image.tmdb.org/t/p/w500' +
                                                tv[index].poster_path,
                                            vote:
                                                tv[index].vote_average,
                                                id:
                                                tv[index].id
                                          ))));},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                tv[index].backdrop_path),
                                        fit: BoxFit.cover),
                                  ),
                                  height: 140,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: modified_text(
                                    size: 15,
                                    text: tv[index].original_title != null
                                        ? tv[index].original_title
                                        : 'Loading'),
                              )
                            ],
                          ),
                        );
                      }))
            ],
          );
        }
      ),
    );
  }
}