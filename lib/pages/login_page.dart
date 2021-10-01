
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:volv_saswat/models/Slides.dart';
import 'package:volv_saswat/pages/cards_page.dart';
import 'package:volv_saswat/utils/AppTheme.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PageController imagesPageController = PageController(initialPage: 0);
  List<Slides> slidesList  = [
    Slides(title: "Lorem ipsum", subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", image: "assets/login_1.png", color1: Color(0xFFFAF0CA), color2: Color(0xFFEACFC7)),
    Slides(title: "dolor sit amet", subtitle: "sed do elusmod tempor incididunt ut labore et dolore magna aliqua.", image: "assets/login_2.png", color1: Color(0xFFC0D6C6), color2: Color(0xFFDFD1C2)),
    Slides(title: "consectetur adipising", subtitle: "quis nostrud ullamo laboris nisi ut aliquip ex", image: "assets/login_3.png", color1: Color(0xFFB2BCDC), color2: Color(0xFFDFD0C0))
  ];
  int activePage = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CardsPage(),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                slidesList[activePage].color1,
                slidesList[activePage].color2,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: imagesPageController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: slidesList.length,
                onPageChanged: (int page){
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        slidesList[index].image,
                        height: 200,
                      ),
                      Text(slidesList[index].title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.only(left: 80, right: 80),
                        child: Text(slidesList[index].subtitle, textAlign: TextAlign.center,),
                      )
                    ],
                  );

                },
              ),
            ),
            SmoothPageIndicator(
              controller: imagesPageController,
              count:  slidesList.length,
              effect:  WormEffect(dotWidth: 7, dotHeight: 7, activeDotColor: Colors.black),
            ),
            SizedBox(height: 50,),
            InkWell(
              child: WidgetLoginButton(text: "Sign in with Apple", iconPath: "assets/apple_logo.png",),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardsPage(),
                    ));
              },
            ),
            InkWell(
              child: WidgetLoginButton(text: "Sign in with Google", iconPath: "assets/google_logo.png",),
              onTap: (){
                signInWithGoogle();
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {

                  },
                  child: Text("Sign Up", style: TextStyle(color: Colors.black),),
                )
              ],
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class WidgetLoginButton extends StatelessWidget {
  WidgetLoginButton({required this.text, required this.iconPath});
  final String text;
  final String iconPath;
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 250,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.loginButton,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset.zero, // Shadow position
            spreadRadius: 0
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(text, style: TextStyle(color: Colors.black),),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
                iconPath,
                height: 20,
            ),
          ),
        ],
      ),
    );
  }

}