import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class EcardPreviewScreen extends StatefulWidget {
  final List<String>? listIncommingData;
  final String? strImageAsset;
 EcardPreviewScreen({this.listIncommingData,this.strImageAsset});
  @override
  _EcardPreviewScreenState createState() => _EcardPreviewScreenState();
}

class _EcardPreviewScreenState extends State<EcardPreviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String>? listIncommingData;
  String? strImageAsset;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Row(
            children: [InkWell(
              onTap: (){
                Navigator.pop(context);
                },
              child: SvgPicture.asset(
                'assets/svg_pics/back_arrow.svg',
                width: 50,
              ),
            ), const SizedBox(width: 150,), InkWell(
              onTap: (){

                },
              child: Text(
                'Copy',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),
                             )

                          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Container(
              width: 120,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.pinkAccent,
                        ),
                        child: Center(child: Text('Images',style: kBoldSmallStyle,)),
                      )),
            Tab(child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pinkAccent,
              ),
              child: Center(child: Text('Messages',style: kBoldSmallStyle,)),
            )),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
      Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 140,top: 20),
        child: Container(
          width: 130,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Image.asset(strImageAsset.toString(),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
      Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20),
         border: Border.all(width: 2),
         color: Colors.yellow,
       ),
       child: Padding(
         padding: const EdgeInsets.all(10),
         child: ListView.builder(
             itemCount: listIncommingData!.length,
             itemBuilder: (BuildContext context, int index) {
               return
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Container(
                     width: double.infinity,
                     height: 100,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(width: 2),
                       color: Colors.grey.shade200,
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Center(
                         child: Text(listIncommingData![index]),
                       ),
                     ),
//
//
                   ),
                 );
             }
         ),
       ))
       ],
      ),
    );
  }
}


