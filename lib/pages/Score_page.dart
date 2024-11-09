// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';

class Score_page extends StatefulWidget {
  const Score_page({super.key});

  @override
  State<Score_page> createState() => _Score_pageState();
}

class Row_buttons extends StatelessWidget {
  final String text;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const Row_buttons({
    Key? key,
    required this.text,
    required this.onDecrease,
    required this.onIncrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 50,
            width: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, alignment: Alignment.center),
              child: Text('-'),
              onPressed: onDecrease,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            height: 50,
            width: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, alignment: Alignment.center),
              child: Text('+'),
              onPressed: onIncrease,
            ),
          ),
        )
      ],
    );
  }
}

class Row_checkbox extends StatelessWidget {
  final String text;
  final ValueChanged<bool?> Checked;
  final bool Parked;

  const Row_checkbox({
    Key? key,
    required this.text,
    required this.Checked,
    required this.Parked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            text,
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Checkbox(
              value: Parked,
              onChanged: Checked,
              side: BorderSide(color: Colors.white, width: 3)),
        ),
      ],
    );
  }
}

class _Score_pageState extends State<Score_page> {
  //VARIABLES
  int total_points = 0;
  int auto_points = 0;
  int teleop_points = 0;
  int endgame_points = 0;
  int penalty_points = 0;
  bool isParkedChecked1 = false;
  bool isParkedChecked2 = false;

  int samples_net_zone_auto = 0;
  int samples_low_basket_auto = 0;
  int samples_high_basket_auto = 0;
  int specimen_low_chamber_auto = 0;
  int specimen_high_chamber_auto = 0;

  int samples_net_zone_tele = 0;
  int samples_low_basket_tele = 0;
  int samples_high_basket_tele = 0;
  int specimen_low_chamber_tele = 0;
  int specimen_high_chamber_tele = 0;

  int robot1_selectedAscentLevel = -1;
  int robot2_selectedAscentLevel = -1;

  int robot1_parking_points = 0;
  int robot2_parking_points = 0;

  int minor_penalties = 0;
  int major_penalties = 0;

  //FUNCTIONS

  void reset() {
    setState(() {
      total_points = 0;
      auto_points = 0;
      teleop_points = 0;
      endgame_points = 0;
      penalty_points = 0;
      isParkedChecked1 = false;
      isParkedChecked2 = false;

      samples_net_zone_auto = 0;
      samples_low_basket_auto = 0;
      samples_high_basket_auto = 0;
      specimen_low_chamber_auto = 0;
      specimen_high_chamber_auto = 0;

      samples_net_zone_tele = 0;
      samples_low_basket_tele = 0;
      samples_high_basket_tele = 0;
      specimen_low_chamber_tele = 0;
      specimen_high_chamber_tele = 0;
      robot1_selectedAscentLevel = -1;
      robot2_selectedAscentLevel = -1;

      robot1_parking_points = 0;
      robot2_parking_points = 0;

      minor_penalties = 0;
      major_penalties = 0;
    });
  }

  void calculatingTotalScore() {
    setState(() {
      total_points =
          auto_points + teleop_points + endgame_points + penalty_points;
    });
  }

  void calculatingAutoPoints() {
    auto_points = samples_net_zone_auto * 2 +
        samples_low_basket_auto * 4 +
        samples_high_basket_auto * 8 +
        specimen_low_chamber_auto * 6 +
        specimen_high_chamber_auto * 10;
    if (isParkedChecked1) auto_points += 3;
    if (isParkedChecked2) auto_points += 3;
    calculatingTotalScore();
  }

  void calculatingTeleOpPoints() {
    teleop_points = samples_net_zone_tele * 2 +
        samples_low_basket_tele * 4 +
        samples_high_basket_tele * 8 +
        specimen_low_chamber_tele * 6 +
        specimen_high_chamber_tele * 10;

    calculatingTotalScore();
  }

  void calculatingEndGamePoints() {
    setState(() {
      endgame_points = robot1_parking_points + robot2_parking_points;
    });
    calculatingTotalScore();
  }

  void calculatingPenaltiesPoints() {
    setState(() {
      penalty_points = minor_penalties * (-5) + major_penalties * (-15);
    });
    calculatingTotalScore();
  }

  Function(bool?)? Checked1(bool? value) {
    setState(() {
      isParkedChecked1 = !isParkedChecked1;
      if (isParkedChecked1) {
        auto_points += 3;
      } else {
        auto_points -= 3;
      }
      calculatingTotalScore();
    });
  }

  Function(bool?)? Checked2(bool? value) {
    setState(() {
      isParkedChecked2 = !isParkedChecked2;
      if (isParkedChecked2) {
        auto_points += 3;
      } else {
        auto_points -= 3;
      }
      calculatingTotalScore();
    });
  }

  void decreaseSampleNetZone_auto() {
    setState(() {
      if (samples_net_zone_auto > 0) {
        samples_net_zone_auto -= 1;
        if (samples_net_zone_tele > 0) {
          samples_net_zone_tele -= 1;
        }
      }
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void increaseSampleNetZone_auto() {
    setState(() {
      samples_net_zone_auto += 1;
      samples_net_zone_tele += 1;
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void decreaseSampleLowBasket_auto() {
    setState(() {
      if (samples_low_basket_auto > 0) {
        samples_low_basket_auto -= 1;
        if (samples_low_basket_tele > 0) {
          samples_low_basket_tele -= 1;
        }
      }
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void increaseSampleLowBasket_auto() {
    setState(() {
      samples_low_basket_auto += 1;
      samples_low_basket_tele += 1;
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void decreaseSampleHighBasket_auto() {
    setState(() {
      if (samples_high_basket_auto > 0) {
        samples_high_basket_auto -= 1;
        if (samples_high_basket_tele > 0) {
          samples_high_basket_tele -= 1;
        }
      }
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void increaseSampleHighBasket_auto() {
    setState(() {
      samples_high_basket_auto += 1;
      samples_high_basket_tele += 1;
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void decreaseSpecimenLowChamber_auto() {
    setState(() {
      if (specimen_low_chamber_auto > 0) {
        specimen_low_chamber_auto -= 1;
        if (specimen_low_chamber_tele > 0) {
          specimen_low_chamber_tele -= 1;
        }
      }
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void increaseSpecimenLowChamber_auto() {
    setState(() {
      specimen_low_chamber_auto += 1;
      specimen_low_chamber_tele += 1;
    });
    calculatingAutoPoints();
    calculatingTeleOpPoints();
  }

  void decreaseSpecimenHighChamber_auto() {
    setState(() {
      if (specimen_high_chamber_auto > 0) {
        specimen_high_chamber_auto -= 1;
        if (specimen_high_chamber_tele > 0) {
          specimen_high_chamber_tele -= 1;
        }
      }
      calculatingAutoPoints();
      calculatingTeleOpPoints();
    });
  }

  void increaseSpecimenHighChamber_auto() {
    setState(() {
      specimen_high_chamber_auto += 1;
      specimen_high_chamber_tele += 1;
    });
    calculatingAutoPoints();
    calculatingTeleOpPoints();
  }

  void decreaseSampleNetZone_tele() {
    setState(() {
      if (samples_net_zone_tele > 0) {
        samples_net_zone_tele -= 1;
      }
      calculatingTeleOpPoints();
    });
  }

  void increaseSampleNetZone_tele() {
    setState(() {
      samples_net_zone_tele += 1;
      calculatingTeleOpPoints();
    });
  }

  void decreaseSampleLowBasket_tele() {
    setState(() {
      if (samples_low_basket_tele > 0) {
        samples_low_basket_tele -= 1;
      }
      calculatingTeleOpPoints();
    });
  }

  void increaseSampleLowBasket_tele() {
    setState(() {
      samples_low_basket_tele += 1;
      calculatingTeleOpPoints();
    });
  }

  void decreaseSampleHighBasket_tele() {
    setState(() {
      if (samples_high_basket_tele > 0) {
        samples_high_basket_tele -= 1;
      }
      calculatingTeleOpPoints();
    });
  }

  void increaseSampleHighBasket_tele() {
    setState(() {
      samples_high_basket_tele += 1;
      calculatingTeleOpPoints();
    });
  }

  void decreaseSpecimenLowChamber_tele() {
    setState(() {
      if (specimen_low_chamber_tele > 0) {
        specimen_low_chamber_tele -= 1;
      }
      calculatingTeleOpPoints();
    });
  }

  void increaseSpecimenLowChamber_tele() {
    setState(() {
      specimen_low_chamber_tele += 1;
    });
    calculatingTeleOpPoints();
  }

  void decreaseSpecimenHighChamber_tele() {
    setState(() {
      if (specimen_high_chamber_tele > 0) {
        specimen_high_chamber_tele -= 1;
      }
      calculatingTeleOpPoints();
    });
  }

  void increaseSpecimenHighChamber_tele() {
    setState(() {
      specimen_high_chamber_tele += 1;
    });
    calculatingTeleOpPoints();
  }

  void noascent_robot1() {
    setState(() {
      robot1_parking_points = 0;
      robot1_selectedAscentLevel = 0;
    });
    calculatingEndGamePoints();
  }

  void firstlevelascent_robot1() {
    setState(() {
      robot1_parking_points = 3;
      robot1_selectedAscentLevel = 1;
    });
    calculatingEndGamePoints();
  }

  void secondlevelascent_robot1() {
    setState(() {
      robot1_parking_points = 15;
      robot1_selectedAscentLevel = 2;
    });
    calculatingEndGamePoints();
  }

  void thirdlevelascent_robot1() {
    setState(() {
      robot1_parking_points = 30;
      robot1_selectedAscentLevel = 3;
    });
    calculatingEndGamePoints();
  }

  void noascent_robot2() {
    setState(() {
      robot2_parking_points = 0;
      robot2_selectedAscentLevel = 0;
    });
    calculatingEndGamePoints();
  }

  void firstlevelascent_robot2() {
    setState(() {
      robot2_parking_points = 3;
      robot2_selectedAscentLevel = 1;
    });
    calculatingEndGamePoints();
  }

  void secondlevelascent_robot2() {
    setState(() {
      robot2_parking_points = 15;
      robot2_selectedAscentLevel = 2;
    });
    calculatingEndGamePoints();
  }

  void thirdlevelascent_robot2() {
    setState(() {
      robot2_parking_points = 30;
      robot2_selectedAscentLevel = 3;
    });
    calculatingEndGamePoints();
  }

  void decreaseMinorPenalties() {
    setState(() {
      if (minor_penalties > 0) {
        minor_penalties -= 1;
      }
      calculatingPenaltiesPoints();
    });
  }

  void increaseMinorPenalties() {
    setState(() {
      minor_penalties += 1;
    });
    calculatingPenaltiesPoints();
  }

  void decreaseMajorPenalties() {
    setState(() {
      if (major_penalties > 0) {
        major_penalties -= 1;
      }
      calculatingPenaltiesPoints();
    });
  }

  void increaseMajorPenalties() {
    setState(() {
      major_penalties += 1;
    });
    calculatingPenaltiesPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(109, 25, 60, 1),
      appBar: AppBar(
        title: Text("Total points: $total_points"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reset,
          )
        ],
        elevation: 1,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.27), BlendMode.darken),
                image: AssetImage('assets/images/Fundal.png'),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Autonomous: $auto_points",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    Divider(
                      thickness: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Samples and specimens: ',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                      ),
                    ),

                    //This structure will be the same in the TeleOp
                    Row_buttons(
                        text: 'Net Zone: $samples_net_zone_auto',
                        onDecrease: decreaseSampleNetZone_auto,
                        onIncrease: increaseSampleNetZone_auto),
                    Row_buttons(
                        text: 'Low Basket: $samples_low_basket_auto',
                        onDecrease: decreaseSampleLowBasket_auto,
                        onIncrease: increaseSampleLowBasket_auto),
                    Row_buttons(
                        text: 'High Basket: $samples_high_basket_auto',
                        onDecrease: decreaseSampleHighBasket_auto,
                        onIncrease: increaseSampleHighBasket_auto),
                    Row_buttons(
                        text: 'Low Chamber: $specimen_low_chamber_auto',
                        onDecrease: decreaseSpecimenLowChamber_auto,
                        onIncrease: increaseSpecimenLowChamber_auto),
                    Row_buttons(
                        text: 'High Chamber: $specimen_high_chamber_auto',
                        onDecrease: decreaseSpecimenHighChamber_auto,
                        onIncrease: increaseSpecimenHighChamber_auto),

                    //PARKING
                    Row_checkbox(
                        text: 'Robot 1 parked: ',
                        Checked: Checked1,
                        Parked: isParkedChecked1),
                    Row_checkbox(
                        text: 'Robot 2 parked: ',
                        Checked: Checked2,
                        Parked: isParkedChecked2)
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),

            //TELE OP

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            'TeleOP: $teleop_points',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Samples and specimens: ',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)),
                        ),
                      ),
                      Row_buttons(
                          text: 'Net Zone: $samples_net_zone_tele',
                          onDecrease: decreaseSampleNetZone_tele,
                          onIncrease: increaseSampleNetZone_tele),
                      Row_buttons(
                          text: 'Low Basket: $samples_low_basket_tele',
                          onDecrease: decreaseSampleLowBasket_tele,
                          onIncrease: increaseSampleLowBasket_tele),
                      Row_buttons(
                          text: 'High Basket: $samples_high_basket_tele',
                          onDecrease: decreaseSampleHighBasket_tele,
                          onIncrease: increaseSampleHighBasket_tele),
                      Row_buttons(
                          text: 'Low Chamber: $specimen_low_chamber_tele',
                          onDecrease: decreaseSpecimenLowChamber_tele,
                          onIncrease: increaseSpecimenLowChamber_tele),
                      Row_buttons(
                          text: 'High Chamber: $specimen_high_chamber_tele',
                          onDecrease: decreaseSpecimenHighChamber_tele,
                          onIncrease: increaseSpecimenHighChamber_tele),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(20))),
            ),

            //END GAME
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "EndGame: $endgame_points",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Divider(
                        thickness: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Robot 1 ascented: ',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('No'),
                                    onPressed: noascent_robot1,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot1_selectedAscentLevel == 0
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(20),
                                                    right: Radius.circular(0))),
                                        elevation: 0),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('A1'),
                                    onPressed: firstlevelascent_robot1,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot1_selectedAscentLevel == 1
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(0),
                                                bottom: Radius.circular(0))),
                                        elevation: 0),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('A2'),
                                    onPressed: secondlevelascent_robot1,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot1_selectedAscentLevel == 2
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(0),
                                                bottom: Radius.circular(0))),
                                        elevation: 0),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('A3'),
                                    onPressed: thirdlevelascent_robot1,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot1_selectedAscentLevel == 3
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(0),
                                                    right:
                                                        Radius.circular(20))),
                                        elevation: 0),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(109, 25, 60, 1),
                                border:
                                    Border.all(color: Colors.white, width: 4),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Robot 2 ascented: ',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('No'),
                                    onPressed: noascent_robot2,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot2_selectedAscentLevel == 0
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(20),
                                                    right: Radius.circular(0))),
                                        elevation: 0),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('A1'),
                                    onPressed: firstlevelascent_robot2,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot2_selectedAscentLevel == 1
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(0),
                                                bottom: Radius.circular(0))),
                                        elevation: 0),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('A2'),
                                    onPressed: secondlevelascent_robot2,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot2_selectedAscentLevel == 2
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(0),
                                                bottom: Radius.circular(0))),
                                        elevation: 0),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    child: Text('A3'),
                                    onPressed: thirdlevelascent_robot2,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            robot2_selectedAscentLevel == 3
                                                ? Colors.grey
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(0),
                                                    right:
                                                        Radius.circular(20))),
                                        elevation: 0),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(109, 25, 60, 1),
                                border:
                                    Border.all(color: Colors.white, width: 4),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(20))),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 8),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Penalties: $penalty_points',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Divider(
                        thickness: 4,
                      ),
                      Row_buttons(
                          text: 'Minor penalties: $minor_penalties',
                          onDecrease: decreaseMinorPenalties,
                          onIncrease: increaseMinorPenalties),
                      Row_buttons(
                          text: 'Major penalties: $major_penalties',
                          onDecrease: decreaseMajorPenalties,
                          onIncrease: increaseMajorPenalties)
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ),
      ),
    );
  }
}
