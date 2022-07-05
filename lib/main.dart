import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:time_app/reducer.dart';

import 'app_state.dart';
import 'middleware.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final store = Store<AppState>(reducer,
      initialState: AppState.initialState(),
      middleware: [thunkMiddleware]);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // List<dynamic> locations = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   const Text("Flutter Redux demo"),
      ),
      body:   Center(
        child: SizedBox(
          height: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              // display time and location
              StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (_, state) {
                  return  Text(
                    'The time in ${state.location} is ${state.time}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  );
                },
              ),

              // fetch time button
              StoreConnector<AppState, FetchTime>(
                converter: (store) => () => store.dispatch(fetchTime),
                builder: (_, fetchTimeCallback) {
                  return   SizedBox(
                    width: 250,
                    height: 50,
                    child: RaisedButton(
                        color: Colors.amber,
                        textColor: Colors.brown,
                        onPressed: fetchTimeCallback,
                        child:   const Text(
                            "Click to fetch time",
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                            fontSize: 25
                          ),
                        )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

typedef FetchTime = void Function();