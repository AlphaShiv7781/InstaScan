import 'package:flutter/material.dart';
import 'package:instascan/screens/auth_screens/signup_screen.dart';
import 'package:instascan/screens/onboarding_screens/onboarding_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: ClipRect(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: isLastPage?getStarted(): Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               TextButton(
                   onPressed: ()=>pageController.jumpToPage(controller.items.length-1),
                   child: Text(
                       'Skip'
                   ),
               ),

               SmoothPageIndicator(

                   controller: pageController,
                   count: controller.items.length,
                   onDotClicked: (index){
                     pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                   },
                   effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      activeDotColor: Colors.cyan,
                      dotColor: Colors.grey,
                   ),
               ),

               TextButton(
                 onPressed: ()=>pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn),
                 child: Text(
                     'Next'
                 ),
               ),
             ],
          ),
        ),
      ),


      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context , index){

               return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Image.asset(controller.items[index].imageUrl),
                    SizedBox(height: 15,),
                    Text(
                      controller.items[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      textAlign: TextAlign.center,
                      controller.items[index].description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                 ],
               );
            },
            onPageChanged: (index)=> setState(() {
              isLastPage = index == controller.items.length-1;
            }),
        ),
      ),
    );
  }

  Widget getStarted(){

    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width*.9,
        child: TextButton(
            onPressed: ()async{

              final pres = await SharedPreferences.getInstance();
              pres.setBool('onboarding', true);

              if(!mounted)return;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
            },
            child: Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                ),
            ),
        ),
    );

}

}
