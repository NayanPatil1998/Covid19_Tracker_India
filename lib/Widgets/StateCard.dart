import 'package:covid19_tracker/Models/CaseModel.dart';
import 'package:covid19_tracker/Widgets/counter.dart';
import 'package:covid19_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  const StateCard({
    Key key,
    this.state,
    this.onPressed,
  }) : super(key: key);
  final Statewise state;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: kShadowColor,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              state.state,
              style: kHeadingTextStyle,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Counter(
                  color: kInfectedColor,
                  number: state.active,
                  title: "Infected",
                ),
                Counter(
                  color: kDeathColor,
                  number: state.deaths,
                  title: "Deaths",
                ),
                Counter(
                  color: kRecovercolor,
                  number: state.recovered,
                  title: "Recovered",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
