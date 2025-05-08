import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<List<Colour>> dummyColours = [
    [
      Colour("Red", false, Colors.red, "#FF0000"),
      Colour("Pink", true, Colors.pink, "#FFC0CB"),
    ],
    [
      Colour("Green", false, Colors.green, "#00FF00"),
      Colour("Lime", false, Colors.lime, "#00FF00"),
    ],
    [
      Colour("Blue", true, Colors.blue, "#0000FF"),
      Colour("Cyan", false, Colors.cyan, "#00FFFF"),
    ],
    [
      Colour("Yellow", false, Colors.yellow, "#FFFF00"),
      Colour("Orange", true, Colors.orange, "#FFA500"),
    ],
    [
      Colour("Purple", false, Colors.purple, "#800080"),
      Colour("Indigo", false, Colors.indigo, "#4B0082"),
    ],
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: dummyColours.length,
                    primary: false,
                    itemExtent: 100,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      return Center(
                        child: Container(
                          height: 20,
                          width: 60,
                          color: dummyColours[i].where((t)=>t.selected).firstOrNull?.color ?? Colors.amber,
                        ),
                      );
                    },

                  ),
                ),
              ),

              Flexible(
                flex: 4,
                child: ListView.builder(
                  itemCount: dummyColours.length,
                  primary: false,
                  itemExtent: 100,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dummyColours[i].where((t)=>t.selected).firstOrNull?.name ?? "red"),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black
                                ),
                              ),
                              height: 20,
                              child: Text(dummyColours[i].where((t)=>t.selected).firstOrNull?.colorCode ?? "red"),
                            )
                          ],
                        ),

                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                              dummyColours[i].length,
                                  (index){
                                return Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      int j = dummyColours[i].indexWhere((t)=>t.selected);

                                      if(j != -1){
                                        dummyColours[i][j].selected = !dummyColours[i][j].selected;
                                      }

                                      dummyColours[i][index].selected = !dummyColours[i][index].selected;
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 60,
                                          color: dummyColours[i][index].color,
                                        ),
                                        Text(dummyColours[i][index].colorCode)
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ],
                    );
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Colour {
  final String name;
  bool selected;
  final Color color;
  final String colorCode;

  Colour(this.name, this.selected, this.color, this.colorCode);
}
