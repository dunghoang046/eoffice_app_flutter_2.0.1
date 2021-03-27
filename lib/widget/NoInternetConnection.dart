import 'package:flutter/material.dart';

class NoInternetConnection extends StatefulWidget {
  final VoidCallback action;

  NoInternetConnection({this.action});
  _NoInternetConnection createState() => _NoInternetConnection();
}

class _NoInternetConnection extends State<NoInternetConnection> {
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Không có kết nối mạng & xem lại',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.refresh,
                size: 30.0,
              ),
              onPressed: widget.action,
            ),
          ),
        ],
      ),
    );
  }
}
