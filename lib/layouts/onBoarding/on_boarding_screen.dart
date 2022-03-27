
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/layouts/login/shop_login_screen.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  late String image;
  late String title;
  late String body;

  BoardingModel(
      {
        required this.image,
        required this.title,
        required this.body,
      }
      );

}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding =[
    BoardingModel(
        image: "assets/images/logo.jpg",
        title: "On Board 1 Title",
        body: "On Board 1 Body"),
    BoardingModel(
        image: "assets/images/logo.jpg",
        title: "On Board 2 Title",
        body: "On Board 2 Body"),
    BoardingModel(
        image: "assets/images/logo.jpg",
        title: "On Board 3 Title",
        body: "On Board 3 Body"),
  ];
  bool isLast = false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
      }
    },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed:()=>submit(),
              child: const Text("SKIP"),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index)=>  buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index){
                    if(index == boarding.length - 1){
                      setState(() {
                        isLast = true;
                      });
                    }else{
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 40.0,),
              Row(children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10.0,
                      expansionFactor: 4,
                      dotWidth: 10.0,
                      spacing: 5.0,
                    ),
                    count: boarding.length
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    else{
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }

                  },
                  backgroundColor: defaultColor,
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],),
            ],
          ),
        )
    );
  }
}

Widget buildBoardingItem(BoardingModel model)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage( '${model.image}'),
      ),
    ),
    const SizedBox(height: 30.0,),
    Text(
      '${model.title}',
      style: const TextStyle(fontSize: 24.0),
    ),
    const SizedBox(height: 15.0,),
    Text(
      '${model.body}',
      style:const TextStyle(fontSize: 14.0),
    ),
    const SizedBox(height: 30.0,),



  ],
);
