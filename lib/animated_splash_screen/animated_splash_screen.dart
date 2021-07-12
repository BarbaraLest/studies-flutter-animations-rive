import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animations_flare/login/login_screen.dart';
import 'package:rive/rive.dart';

class AnimationSplashScreen extends StatefulWidget {
  const AnimationSplashScreen({Key? key}) : super(key: key);

  @override
  AnimationSplashScreenState createState() => AnimationSplashScreenState();
}

class AnimationSplashScreenState extends State<AnimationSplashScreen> {
  late Artboard _artboard;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
    // Future.delayed(Duration(seconds: 5)).then((value) => Navigator.of(context)
    //     .pushReplacement(
    //         MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/animations/girl_stars.riv');
    final file = RiveFile.import(bytes);

    setState(() {
      _artboard = file.mainArtboard;
    });
  }

  void _pulse() {
    _artboard.addController(_controller = SimpleAnimation('spin'));
    setState(() => _controller?.isActive = true);
  }

  @override
  Widget build(BuildContext context) {
    // _pulse();
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 600,
              width: MediaQuery.of(context).size.width,
              child: _artboard != null
                  ? Rive(artboard: _artboard, fit: BoxFit.cover)
                  : Container(color: Colors.blueAccent),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 250,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hi, everyone",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[400],
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "This is an example of flutter animation using Rive",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _pulse();
                    },
                    child: Text(
                      "Tap to play",
                      style: TextStyle(fontSize: 25),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurple.shade400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
