
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:clipboard/clipboard.dart';
import '../../constants/constants.dart';

class ECardsPreviewScreen extends StatefulWidget {
  final List<String>? listIncommingData;
  final String? strImageAsset;
  ECardsPreviewScreen({this.listIncommingData,this.strImageAsset});

  @override
  State<ECardsPreviewScreen> createState() => _ECardsPreviewScreenState();
}

class _ECardsPreviewScreenState extends State<ECardsPreviewScreen> {

  late TabController _tabController;
  List<String>? listIncommingData;
  String? strImageAsset;
  int selectedButton = 1;
  @override
  void initState() {
    super.initState();
    if(widget.listIncommingData != null) {
      setState(() {
        listIncommingData = widget.listIncommingData!;
        strImageAsset=widget.strImageAsset;
      });
    }
    if(widget.strImageAsset != null) {
      setState(() {
        strImageAsset=widget.strImageAsset;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/svg_pics/back_arrow.svg',
                  ),
                ),
                Visibility(
                  visible: selectedButton==2 ?false:true,
                  child: InkWell(
                    onTap: (){

                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        right: 30,
                      ),
                      child:  Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff1947E5),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xfffffFFF),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedButton = 1;
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red;
                            } else if (selectedButton == 1) {
                              return Colors.red;
                            } else {
                              return Color(0xfffffFFF);
                            }
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            } else if (selectedButton == 1) {
                              return Colors.white;
                            } else {
                              return Colors.black;
                            }
                          },
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Image',
                          style:TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedButton = 2;
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red;
                            } else if (selectedButton == 2) {
                              return Colors.red;
                            } else {
                              return Color(0xfffffFFF);
                            }
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            } else if (selectedButton == 2) {
                              return Colors.white;
                            } else {
                              return Colors.black;
                            }
                          },
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Message',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selectedButton == 1)
            Padding(
              padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 140,
                  top: 20),
              child: Container(
                height: 330,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2),
                  image: DecorationImage(
                    image: AssetImage('${strImageAsset.toString()}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          if (selectedButton == 2)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 140,
                    top: 20
                ),
                child: Container(
                  height: 600,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                    ),
                    color: const Color(0xffFFBD12),
                  ),
                  child: ListView.builder(
                      itemCount: listIncommingData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                            right: 10,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      listIncommingData![index],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        FlutterClipboard.copy(listIncommingData![index]);
                                        const snackBar = SnackBar(
                                          content: Text('Text copied to clipboard!'),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
//
//
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


