import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class NeumorphicTestView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            Neumorphic(
              child: SizedBox(
                height: 100,
                width: 100,
              ),
            ),
            Neumorphic(
              style: NeumorphicStyle(
                color: Colors.grey[300],
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 8,
                lightSource: LightSource.topLeft,
              ),
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.face,
                color: Colors.blueGrey,
              ),
            ),
          ]
        )
      ),
    );
  }
}