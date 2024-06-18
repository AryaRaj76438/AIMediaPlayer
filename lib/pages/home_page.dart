import 'package:aimelody/model/radio.dart';
import 'package:aimelody/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio>? radios;

  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  // fetchRadios()async{
  //   final radiosJson = await rootBundle.loadString("assets/radio.json");
  //   radios = MyRadioList.fromJson(radiosJson).radios;
  //   print(radios);
  // }
    fetchRadios() async {
    final radiosJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radiosJson).radios;
    // print(radios);
    setState(() {}); // Ensure the UI updates after fetching radios
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
          .size(context.screenWidth, context.screenHeight)
          .withGradient(
            LinearGradient(
              colors: [
                AIColors.primaryColor1,
                AIColors.primaryColor2
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
              ),
          ).make(),
          AppBar(
            title: "AI Radio".text.xl4.bold.white.make().shimmer(
              primaryColor: Vx.purple300,
              secondaryColor: Colors.white
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ).h(100.0).p16(),
          VxSwiper.builder(
            itemCount: radios?.length??0, 
            aspectRatio: 1,
            enlargeCenterPage: true,
            itemBuilder: (context, index){
              final rad = radios?[index];
              if(rad==null){
                return Container();
              }
              return VxBox(
                child: ZStack([
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: VxBox(
                      child: rad.category.text.uppercase.white.make().px16(),
                    )
                    .height(40)
                    .alignCenter
                    .withRounded(value: 10.0)
                    .black
                    .make(),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack([
                      rad.name.text.xl3.semiBold.white.make(),
                      // 5.heightBox,
                      rad.tagline.text.sm.white.semiBold.make()
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: VStack(
                      [
                        Icon(
                          CupertinoIcons.play_circle, 
                          color: Colors.white,
                        ),
                        10.heightBox,
                        "Double tap to play".text.gray300.make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                ]))
                .clip(Clip.antiAlias)
              .bgImage(DecorationImage(
                image: NetworkImage(rad.image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              ))
              .border(color: Colors.black, width: 5.0)
              .withRounded(value: 60.0)
              .make()
              .onInkDoubleTap((){})
              .p16();
            },
          ).centered(),

          Align(
            alignment: Alignment.bottomCenter,
            child: Icon(
              CupertinoIcons.stop_circle,
              color: Colors.white,
              size: 50.0,
              ).pOnly(bottom: context.percentHeight*12),
          )
        ],
        fit: StackFit.expand,
      ),
    );
  }
}