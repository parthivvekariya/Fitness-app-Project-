
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

class YogaScreen extends StatefulWidget {
  const YogaScreen({super.key});

  @override
  State<YogaScreen> createState() => YogaScreenState();
}

class YogaScreenState extends State<YogaScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
          {
            return[
              SliverAppBar(
                snap: true,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding:  EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child:  Image.network("https://roasting-conflict.000webhostapp.com/images/wellindia/yoga.jpg"),
                        )
                      ],
                    ),
                  ),
                ),
                expandedHeight: 373,
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
                        color: AppColors.grayColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),

                    Container(
                      child: Text("Surya Namaskar, or Sun Salutation, is a sequence of 12 yoga postures performed in a flowing manner. It is a holistic exercise that combines physical, mental, and spiritual benefits, promoting flexibility, strength, and overall well-being. Each posture is synchronized with the breath, creating a harmonious practice that pays homage to the sun, a symbol of vitality and life energy in many cultures."),
                    ),

                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Container(
                      child: Image.asset("assets/images/surya-namaskar.jpeg"),
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
