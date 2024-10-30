// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scorekeeper_boogeybots/pages/Score_page.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(109, 25, 60, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(109, 25, 60, 1),
          title: Center(
              child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Image.asset('assets/images/bara.png', fit: BoxFit.contain),
          )),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 67),
                  child: Container(
                    height: 400,
                    width: 400,
                    //color: Colors.black,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new AssetImage('assets/images/into2.png'))),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: SizedBox(
                    height: 100,
                    width: 400,
                    child: ElevatedButton(
                      child: Center(
                          child: Text(
                        "Go to the app",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromRGBO(109, 25, 60, 1)),
                      )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Score_page()));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(
                    child: Text('Powered by team Boogeybots #19061',
                        style: TextStyle(fontSize: 16, color: Colors.white))),
              )
            ]));
  }
}
