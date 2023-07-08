import 'package:flutter/material.dart';
import 'package:reminder_app/widgets_reusing/onboarding_widget.dart';
import 'fourth_onboarding_screen.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late  PageController _pageController;
  int currentPage = 0;
  @override
  void initState() {
   _pageController=PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                    itemBuilder:(context,index)=>OnBoardingWidget(
                        title: onboard[index].title,
                        description: onboard[index].description,
                        image:onboard[index].image,
                    ),
                  onPageChanged: (int page){
                    setState(() {
                      currentPage=page;
                    });
                  },
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(
                right: 12,
                bottom: 12,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:buildDots(),
                ),
              ),
            ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: () {
              if (currentPage == onboard.length - 1) {
                // Navigate to the next screen (e.g., home screen)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FourthOnBoardingScreen()),
                );
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            backgroundColor: Colors.orange,
            child:const Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        ),

    );
  }
  List<Widget> buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < onboard.length; i++) {
      dots.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == i ? Colors.orange : Colors.black54,
          ),
        ),
      );
    }
    return dots;
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;


  OnboardingData({
    required this.title,
    required this.description,
    required this.image

  });
}
final List<OnboardingData> onboard=[
  OnboardingData(
      title: 'Welcome To App',
      description: 'Let us take care of your \n'
          '      important events',
      image:'assets/svg_pics/illus 1.svg',
  ),
  OnboardingData(
    title: 'Set Reminder',
    description:'Never miss '
        'an important events again',
    image:'assets/svg_pics/illus 2.svg',
  ),
  OnboardingData(
    title: 'Send E-Cards',
    description: '       Never scramble for a last\n'
        '   minute card or message again',
    image:'assets/svg_pics/illus 3.svg',
  ),
];
