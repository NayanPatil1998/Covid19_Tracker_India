import 'package:covid19_tracker/Widgets/StateCard.dart';
import 'package:covid19_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/Models/CaseModel.dart';

class CasesList extends StatelessWidget {
  final List<Statewise> stateList;

  const CasesList({Key key, this.stateList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All states"),
        backgroundColor: Color(0xFF11249F),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: stateList.length,
          itemBuilder: (BuildContext context, int index) {
            return StateCard(
              state: stateList[index],
            );
          }),
    );
  }
}
