
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:volv_saswat/models/Card.dart';
import 'package:volv_saswat/models/Slides.dart';
import 'package:volv_saswat/utils/AppTheme.dart';

class CardsPage extends StatefulWidget {
  CardsPage({Key? key}) : super(key: key);

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  PageController cardPageController = PageController(initialPage: 0);
  List<Cards> cardsList  = [
    Cards(
      title: "Hardik Pandya Might Struggle If Pushed To Bowl",
      subtitle: "Punjab Kings (PBKS) defeated Kolkata Knight Riders (KKR) by five wickets at the Dubai International Stadium to register their fifth win in IPL 2021. With this, PBKS have now moved to the fifth position on the points table with 10 points. KKR, who also have 10 points, are fourth on the points table with superior net run-rate.",
      image: "assets/minion.jpg"
    ),
    Cards(
      title: "Centre declares Chacha Chaudhary as mascot for Namami Gange project",
      subtitle: "The Ministry of Jal Shakti on Friday announced that comic book character Chacha Chaudhary has been selected as the mascot for the Centre’s Namami Gange Programme. At an estimated budget of ₹2.26 crore, the National Mission for Clean Ganga plans to develop and distribute comics, animated videos and e-comics featuring Chacha Chaudhary to educate children towards Ganga and other rivers.",
      image: "assets/chacha.jpg"
    )
  ];
  int activePage = 0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(cardsList[activePage].image),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 100,
                        offset: Offset(0, 150), // Shadow position
                        spreadRadius: 60
                    ),
                  ],
              ),
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: cardPageController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: cardsList.length,
                onPageChanged: (int page){
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Text(cardsList[index].title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        SizedBox(height: 15,),
                        Expanded(
                          child: Text(cardsList[index].subtitle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextButton.icon(
                              icon: Icon(Icons.access_time, color: Colors.grey, size: 18,),
                              label: Text("Today", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),),
                              onPressed: (){

                              },
                            ),
                            TextButton(
                              onPressed: (){

                              },
                              child: Text("CHECK IT OUT", style: TextStyle(color: Colors.orangeAccent),),
                            ),
                            TextButton.icon(
                              icon: Text("Share", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),),
                              label: Icon(Icons.ios_share, color: Colors.grey, size: 18,),
                              onPressed: (){

                              },
                            )
                          ],
                        )
                      ],
                    ),
                  );

                },
              ),
            ),
          ],
        ),
      ),//
    );
  }
}