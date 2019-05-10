import 'package:flutter/material.dart';
import 'package:scroll_shadow_container/scroll_shadow_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable shadow demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  'Here comes the header',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: ScrollShadowContainer(
                elevation: MaterialElevation.the2dp,
                child: ListView(
                  children: List.generate(10, (i) {
                    return ListTile(
                      leading: CircleAvatar(child: Text((i + 1).toString())),
                      title: Text('List item title'),
                      subtitle: Text('List item subtitle'),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 48,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  'Here comes the footer',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
