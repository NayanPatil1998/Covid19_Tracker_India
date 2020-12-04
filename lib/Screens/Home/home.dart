import 'dart:convert';
import 'dart:io';

import 'package:covid19_tracker/Models/CaseModel.dart';
import 'package:covid19_tracker/Widgets/CasesList.dart';
import 'package:covid19_tracker/Widgets/StateCard.dart';
import 'package:covid19_tracker/Widgets/counter.dart';
import 'package:covid19_tracker/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedState = "Maharashtra";
  Future<CaseModel> futureCases;

  Future<CaseModel> fetchCases() async {
    final response = await get("https://api.covid19india.org/data.json");

    if (response.statusCode == 200) {
      return CaseModel.fromMap(jsonDecode(response.body));
    }
  }

  @override
  void initState() {
    super.initState();
    futureCases = fetchCases();
    // futureCases.then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CaseModel>(
          future: futureCases,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data.statewise.map((e) => e.state));
              return Column(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      padding: EdgeInsets.only(left: 40, top: 50, right: 20),
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF3383CD),
                              Color(0xFF11249F),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                        image: DecorationImage(
                          image: AssetImage("assets/images/virus.png"),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: SvgPicture.asset("assets/icons/menu.svg"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/Drcorona.svg",
                                  width: 230,
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                ),
                                Positioned(
                                  top: 20,
                                  left: 150,
                                  child: Text("Covid 19 \nTracker\n India",
                                      style: kHeadingTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 25,
                                      )),
                                ),
                                Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20),
                  //   padding:
                  //       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  //   height: 60,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(25),
                  //     border: Border.all(
                  //       color: Color(0xFFE5E5E5),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  //       SizedBox(width: 20),
                  //       Expanded(
                  //           // child: DropdownButton(
                  //           //   isExpanded: true,
                  //           //   underline: SizedBox(),
                  //           //   icon:
                  //           //       SvgPicture.asset("assets/icons/dropdown.svg"),
                  //           //   value: "Indonesia",
                  //           //   items: [
                  //           //     'Indonesia',
                  //           //     'Bangladesh',
                  //           //     'United States',
                  //           //     'Japan'
                  //           //   ].map<DropdownMenuItem<String>>((String value) {
                  //           //     return DropdownMenuItem<String>(
                  //           //       value: value,
                  //           //       child: Text(value),
                  //           //     );
                  //           //   }).toList(),
                  //           //   onChanged: (value) {},
                  //           // ),
                  //           ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Case Update\n",
                                    style: kTitleTextstyle,
                                  ),
                                  TextSpan(
                                    text: "Newest update",
                                    style: TextStyle(
                                      color: kTextLightColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => CasesList(
                                      stateList: snapshot.data.statewise,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "See details",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  StateCard(
                    state: snapshot.data.statewise[0],
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CasesList(
                            stateList: snapshot.data.statewise,
                          ),
                        ),
                      );
                    },
                  ),

                  // CasesList(
                  //   stateList: snapshot.data.statewise,
                  // )
                  // ListView.builder(
                  //     itemCount: snapshot.data.statewise.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return StateCard(
                  //           state: snapshot.data.statewise[index]);
                  //     })
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);

    path.lineTo(size.width, 0);
    path.close();
    // throw UnimplementedError();

    return path;
    // TODO: implement getClip
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
