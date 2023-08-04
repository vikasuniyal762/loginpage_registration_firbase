import 'package:flutter/material.dart';

class HomePageSections extends StatefulWidget {
  const HomePageSections({super.key});

  @override
  State<HomePageSections> createState() => _HomePageSectionsState();
}

class _HomePageSectionsState extends State<HomePageSections> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Container(
      margin: EdgeInsets.all(20),
      height: size.width * .155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: Offset(0, 10),
          )
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.024),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(
              () {
                currentIndex = index;
              },
            );
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                listOfIcons[index],
                size: MediaQuery.of(context).size.width * 0.076,
                color:
                    index == currentIndex ? Colors.blueAccent : Colors.black38,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
            ],
          ),
        ),
      ),
    ));
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];
}
