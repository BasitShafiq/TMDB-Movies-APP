import 'package:flutter/material.dart';
import '../utils/text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/API_services.dart';

class Description extends StatefulWidget {
  final String? name, description, bannerurl, posterurl, launch_on;
  final int id;
  final double vote;

  Description(
      {this.name,
      this.description,
      this.bannerurl,
      this.posterurl,
      required this.vote,
      this.launch_on,
      required this.id});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late String youtubeId;
  @override
  void initState() {
    APIServices.getYoutubeId(widget.id).then((id) {
      setState(() {
        youtubeId = id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned.fill(
                  child: Image.network(
                    widget.bannerurl!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.only(top: 120),
                    child: GestureDetector(
                      onTap: () async {
                        final youtubeUrl =
                            'https://www.youtube.com/embed/${youtubeId}';
                        if (await canLaunch(youtubeUrl)) {
                          await launch(youtubeUrl);
                        }
                      },
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.yellow,
                              size: 65,
                            ),
                            Text(
                              widget.name!.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'muli',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: modified_text(
                        text: '⭐ Average Rating - ' + widget.vote.toString())),
              ])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child: modified_text(
                  text: widget.name != null ? widget.name : 'Not Loaded',
                  size: 24)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: modified_text(
                  text: 'Releasing On - ' + widget.launch_on!, size: 14)),
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(widget.posterurl!),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: modified_text(text: widget.description, size: 18)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
