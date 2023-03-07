import 'package:flutter/material.dart';
import '../utils/text.dart';
import '../models/movies.dart';
import '../services/API_services.dart';
import '../screens/description.dart';

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(
          future: APIServices.getNowPlaying(),
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
            final List<Movie> trending = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                modified_text(
                  text: 'Now Playing Movies',
                  size: 26,
                ),
                SizedBox(height: 10),
                Container(
                    height: 270,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: trending.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Description(
                                            name: trending[index].title,
                                            bannerurl:'https://image.tmdb.org/t/p/w500' +
                                                trending[index].backdrop_path,
                                            description:
                                                trending[index].overview,
                                            launch_on:
                                                trending[index].release_date,
                                            posterurl:'https://image.tmdb.org/t/p/w500' +
                                                trending[index].poster_path,
                                            vote:
                                                trending[index].original_title,
                                          ))));
                            },
                            child: Container(
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                trending[index].poster_path),
                                      ),
                                    ),
                                    height: 200,
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    child: modified_text(
                                        size: 15,
                                        text: trending[index].title != null
                                            ? trending[index].title
                                            : 'Loading'),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            );
          }),
    );
  }
}
