// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_function_literals_in_foreach_calls, avoid_print, sized_box_for_whitespace

import 'dart:async';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listCard = [
    {
      "id": 1,
      "image":
          "https://i.pinimg.com/236x/53/92/bc/5392bc7bf2090bb90bbd118558568fa6.jpg",
    },
    {
      "id": 1,
      "image":
          "https://i.pinimg.com/236x/53/92/bc/5392bc7bf2090bb90bbd118558568fa6.jpg",
    },
    {
      "id": 2,
      "image":
          "https://i.pinimg.com/236x/9c/b6/47/9cb647e78397244cfee063460aa3abaa--naruto-shippiden-naruto-fan-art.jpg",
    },
    {
      "id": 2,
      "image":
          "https://i.pinimg.com/236x/9c/b6/47/9cb647e78397244cfee063460aa3abaa--naruto-shippiden-naruto-fan-art.jpg",
    },
    {
      "id": 3,
      "image":
          "https://i.pinimg.com/236x/11/32/32/1132329458a776829273a21e94138f49--art-is-walks.jpg",
    },
    {
      "id": 3,
      "image":
          "https://i.pinimg.com/236x/11/32/32/1132329458a776829273a21e94138f49--art-is-walks.jpg",
    },
    {
      "id": 4,
      "image":
          "https://www.pixelstalk.net/wp-content/uploads/images4/Naruto-Shippuden-Phone-Wallpaper-1-349x620.jpg",
    },
    {
      "id": 4,
      "image":
          "https://www.pixelstalk.net/wp-content/uploads/images4/Naruto-Shippuden-Phone-Wallpaper-1-349x620.jpg",
    },
    {
      "id": 5,
      "image":
          "https://www.pixelstalk.net/wp-content/uploads/images4/Naruto-Shippuden-Phone-Wallpaper-3-349x620.jpg",
    },
    {
      "id": 5,
      "image":
          "https://www.pixelstalk.net/wp-content/uploads/images4/Naruto-Shippuden-Phone-Wallpaper-3-349x620.jpg",
    },
    {
      "id": 6,
      "image":
          "https://www.pixelstalk.net/wp-content/uploads/images4/Naruto-Shippuden-Phone-Wallpaper-4-349x620.jpg",
    },
    {
      "id": 6,
      "image":
          "https://www.pixelstalk.net/wp-content/uploads/images4/Naruto-Shippuden-Phone-Wallpaper-4-349x620.jpg",
    },
  ]..shuffle();

  var listSelectedIndex = [];
  var listChoosenIndex = [];

  Timer? timerPlay;
  Timer? timerAlgo;
  var indexAuto = 0;
  var second = 00;
  var minute = 00;
  var listSelectedByAi = [];
  var isAlgorithRun = false;
  List<GlobalKey<FlipCardState>> cardKey = [];
  FlipCardController? flipCardController = FlipCardController();
  bool canClick = true;
  List listBackgroiund = [
    "https://i.pinimg.com/564x/8a/00/88/8a0088c4f071581b0d603c2f25e0c70e.jpg",
    "https://i.pinimg.com/564x/af/54/2d/af542db95c508d4c2ad7a620649e2ce1.jpg",
    "https://i.pinimg.com/564x/f9/43/51/f94351a8e5305377daaf0a40c25b9776.jpg",
    "https://i.pinimg.com/564x/f1/f7/c0/f1f7c06fefdbdc4553a3113efb7e5379.jpg",
    "https://i.pinimg.com/564x/c8/99/31/c8993118883f6dfb2db7ac547f2e59ea.jpg"
  ];
  int indexBg = 0;

  @override
  void initState() {
    indexBg = Random().nextInt(listBackgroiund.length);
    listCard.forEach((element) {
      cardKey.add(GlobalKey<FlipCardState>());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              listBackgroiund.elementAt(
                indexBg,
              ),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: listChoosenIndex.length != 12 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(0.4),
                        ),
                        child: Text(
                          "$minute : $second",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: listCard.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return FlipCard(
                              key: cardKey[index],
                              controller: flipCardController,
                              flipOnTouch: listChoosenIndex.contains(index),
                              fill: Fill
                                  .fillBack, // Fill the back side of the card to make in the same size as the front.
                              direction: FlipDirection.HORIZONTAL, // default
                              front: GestureDetector(
                                onTap: () {
                                  if (!cardKey[index]
                                      .currentState!
                                      .controller!
                                      .isAnimating) {
                                    setCardToSelected(index);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      "https://i.pinimg.com/564x/c5/6a/13/c56a13dff431d0898f9a930024951dbb.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              back: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    listCard[index]["image"].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                listChoosenIndex.length == 12
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(
                                10,
                              ),
                              child: Text("$minute : $second"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  reset();
                                },
                                child: Text("Main Lagi"),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (timerPlay == null ||
                                        !timerPlay!.isActive) {
                                      timerPlay = Timer.periodic(
                                          Duration(seconds: 1), (timer) {
                                        if (second < 59) {
                                          setState(() {
                                            second = second + 1;
                                          });
                                        } else {
                                          setState(() {
                                            second = 0;
                                            minute = minute + 1;
                                          });
                                        }
                                      });
                                    }
                                  },
                                  child: Text("Start"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    reset();
                                  },
                                  child: Text("Reset"),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!isAlgorithRun) myAlgorithm();
                              },
                              child: Text("Run My Algorithm"),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  setCardToSelected(index) {
    if (timerPlay == null || !timerPlay!.isActive) {
      timerPlay = Timer.periodic(Duration(seconds: 1), (timer) {
        if (second < 59) {
          setState(() {
            second = second + 1;
          });
        } else {
          setState(() {
            second = 0;
            minute = minute + 1;
          });
        }
      });
    }
    if (canClick) {
      if (listSelectedIndex.length < 2) {
        setState(() {
          if (!listSelectedIndex.contains(index)) {
            cardKey[index].currentState!.toggleCard();
            listSelectedIndex.add(index);
          }
        });
      }
      if (listSelectedIndex.length == 2) {
        if (!(listCard[listSelectedIndex[0]]['id'] ==
            listCard[listSelectedIndex[1]]['id'])) {
          setState(() {
            canClick = false;
          });
          Timer(Duration(seconds: 1), () {
            listSelectedIndex.forEach((element) {
              setState(() {
                cardKey[element].currentState!.toggleCard();
              });
            });
            setState(() {
              listSelectedIndex.clear();
              canClick = true;
            });
          });
        } else {
          setState(() {
            listChoosenIndex.add(listSelectedIndex[0]);
            listChoosenIndex.add(listSelectedIndex[1]);
            listSelectedIndex.clear();
          });
        }
        if (listChoosenIndex.length == 12) {
          timerPlay!.cancel();
          setState(() {
            isAlgorithRun = false;
          });
        }
      }
    }
  }

  reset() {
    listChoosenIndex.forEach((element) {
      setState(() {
        cardKey[element].currentState!.toggleCard();
      });
    });
    setState(() {
      minute = 00;
      second = 00;
      indexAuto = 0;
      listSelectedIndex.clear();
      listChoosenIndex.clear();
      listSelectedByAi.clear();
      if (timerPlay != null) {
        timerPlay!.cancel();
      }
      if (timerAlgo != null) {
        timerAlgo!.cancel();
      }
      indexBg = Random().nextInt(listBackgroiund.length);
    });
  }

  myAlgorithm() async {
    setState(() {
      isAlgorithRun = true;
    });
    if (timerPlay == null || !timerPlay!.isActive) {
      timerPlay = Timer.periodic(Duration(seconds: 1), (timer) {
        if (second < 59) {
          setState(() {
            second = second + 1;
          });
        } else {
          setState(() {
            second = 0;
            minute = minute + 1;
          });
        }
      });
    }

    timerAlgo = Timer.periodic(Duration(milliseconds: 1200), (timer) {
      // if (timer.tick % 2 == 0) {
      print("index outside $indexAuto");
      cardKey[indexAuto].currentState!.toggleCard();
      Timer(Duration(milliseconds: 700), () {
        if (!listSelectedByAi.contains(listCard[indexAuto]["id"])) {
          print("index inside $indexAuto");
          print("index inside timer $indexAuto");
          cardKey[indexAuto].currentState!.toggleCard();

          setState(() {
            listSelectedByAi.add(listCard[indexAuto]["id"]);
          });
        } else {
          cardKey[listSelectedByAi.indexOf(listCard[indexAuto]["id"])]
              .currentState!
              .toggleCard();
          setState(() {
            listSelectedByAi.add(listCard[indexAuto]["id"]);
            listChoosenIndex.add(indexAuto);
            listChoosenIndex
                .add(listSelectedByAi.indexOf(listCard[indexAuto]["id"]));
          });
        }
        setState(() {
          listSelectedIndex.clear();
          listSelectedIndex.add(indexAuto);
          indexAuto = indexAuto + 1;
          if (indexAuto == listCard.length) {
            timerAlgo!.cancel();
          }
        });
        print(listSelectedByAi);
        if (listChoosenIndex.length == 12) {
          timerPlay!.cancel();
          setState(() {
            isAlgorithRun = false;
          });
        }
      });
    });
  }
}
