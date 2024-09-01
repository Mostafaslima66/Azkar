import 'package:azkar/Models/Onbording_model.dart';
import 'package:azkar/Views/Home_view.dart';
import 'package:flutter/material.dart';

class OnbordingView extends StatefulWidget {
  const OnbordingView({super.key});
  static String id = 'onbording_view';
  @override
  State<OnbordingView> createState() => _OnbordingViewState();
}

class _OnbordingViewState extends State<OnbordingView> {
  final PageController _pageController = PageController();
  int _pageNumber = 0;

  final List<Onbord_Model> _onboardingPages = [
    const Onbord_Model(
      image: 'assets/images/IMG_2166.JPG',
      title: 'البحث بالقرب منك',
      description: 'ابحث عن المتاجر المفضلة التى تريدها\nبموقعك او حيك',
    ),
    const Onbord_Model(
      image: 'assets/images/IMG_2167.JPG',
      title: 'عروض طازجه وجودة',
      description: 'جميع العناصر لها نضارة حقيقية\nوهى مخصص لاحتياجك',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefede6),
      body: Container(
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _pageNumber = value;
            });
          },
          itemCount: _onboardingPages.length,
          itemBuilder: (context, index) {
            return buildOnboardingPage(_onboardingPages[index]);
          },
        ),
      ),
    );
  }

  Widget buildOnboardingPage(onbordModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Image.asset(
            onbordModel.image,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
         const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  onbordModel.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
         const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  onbordModel.description,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
              ),
            ],
          ),
         const SizedBox(height: 230),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        if (_pageNumber < _onboardingPages.length - 1) {
                          _pageController.animateToPage(
                            _pageNumber + 1,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeIn,
                          );
                        } else {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeView()),
  );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xffb19877),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child:const Icon(
                          Icons.arrow_forward,
                          size: 40,
                          color: Color(0xffefede6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
