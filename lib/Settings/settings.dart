import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../constants/constants.dart';
import 'date_formats.dart';
import 'languages.dart';

enum SelectingLanguage {
  Language1,
  Language2,
  Language3,
  Language4,

}
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
          Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg_pics/back_arrow.svg',
                      width: 50,
                    ),
                    const SizedBox(width: 50,),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    )

                  ],
                ),
              ),
              const SizedBox(height: 100,),
              Container(
                height: 160,
                width: 327,
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    )
                ),
                child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            _selectLanguage(context);
                          },
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Language',
                                style: kBoldSmallStyle,
                              ),
                              SvgPicture.asset(
                                'assets/svg_pics/forward.svg',
                                width: 30,

                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            _selectDateFormat(context);
                          },
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date Format',
                                style: kBoldSmallStyle,
                              ),
                              SvgPicture.asset(
                                'assets/svg_pics/forward.svg',
                                width: 30,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
  void _selectDateFormat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return const SelectDateScreen();

      },
    );
  }
  void _selectLanguage(BuildContext context) {

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (BuildContext context) {
        return const SelectLanguage();

      },
    );
  }
}