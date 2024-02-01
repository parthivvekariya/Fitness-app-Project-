import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({Key? key}) : super(key: key);

  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final player = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    super.initState();

    player.playerStateStream.listen((PlayerState state) {
      if (mounted) {
        setState(() {});
      }
    });

    player.durationStream.listen((Duration? duration) {
      if (duration != null && mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });

    player.positionStream.listen((Duration? position) {
      if (position != null && mounted) {
        setState(() {
          _position = position;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                snap: true,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Image.network(
                              "https://roasting-conflict.000webhostapp.com/images/wellindia/meditation.jpg"),
                        ),
                      ],
                    ),
                  ),
                ),
                expandedHeight: 230,
              )
            ];
          },
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Container(
                      child: Text(
                          "Meditation is a practice that involves focusing the mind and promoting a state of heightened awareness and inner peace. By cultivating mindfulness through techniques such as deep breathing or guided visualization, individuals can reduce stress, enhance mental clarity, and foster overall well-being."),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Slider(
                              value: _position.inSeconds.toDouble(),
                              min: 0,
                              max: _duration.inSeconds.toDouble(),
                              onChanged: (double value) {
                                player.seek(Duration(seconds: value.toInt()));
                              },
                              divisions: _duration.inSeconds > 0 ? _duration.inSeconds : null,
                              label: _position.toString(),
                            ),

                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await player.setAsset('assets/audio/15_Minutes_OM_Meditation(128k).m4a');
                                    await player.load();
                                    await player.play();
                                  },
                                  child: Text('Start Meditation'),
                                ),
                                SizedBox(width: 5,),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (player.playing) {
                                      await player.pause();
                                    } else {
                                      await player.play();
                                    }
                                  },
                                  child: player.playing
                                      ? Icon(Icons.pause, size: 36.0)
                                      : Icon(Icons.play_arrow, size: 36.0),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
