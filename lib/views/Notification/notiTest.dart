import 'package:flutter/material.dart';
import 'package:simple_router/simple_router.dart';

class MyNotitest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Mypage3();
  }
}

class Mypage3 extends StatefulWidget {
  _Mypage3 createState() => _Mypage3();
}

class _Mypage3 extends State<Mypage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('page 3'),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: InkWell(
            child: Material(
              color: Colors.transparent,
              child: MaterialButton(
                onPressed: () => SimpleRouter.back(),
                child: Center(
                  child: Text("Quay lại page 2",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1.0)),
                ),
              ),
            ),
          ))),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => SimpleRouter.forward(Page4()),
      //   child: Icon(Icons.chevron_right),
      // ),
    );
  }
}
