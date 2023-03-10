import 'package:flutter/material.dart';

import 'api/http_service.dart';
import 'model/movie_data.dart';
import 'movie_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  String sort = 'desc';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter == 1) {
      //由1開始 該數字代表目前顯示的頁面
      showDialog(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
                title: Text("到達第一頁"),
                content: Text("您已經在查看第一頁了"),
              ));
    } else {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "熱門電影",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          sort = 'desc';
                        });
                      },
                      child: const Text("按人氣升序"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          sort = 'asc';
                        });
                      },
                      child: const Text("按人氣降序"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
                child: FutureBuilder<MovieData?>(
                    future: HttpService.discoverAPI(_counter, sort),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.results!.length,
                            itemBuilder: (context, index) {
                              return MovieCard(
                                  title: snapshot.data!.results![index].title ??
                                      "",
                                  releaseDate: snapshot
                                          .data!.results![index].releaseDate ??
                                      "",
                                  posterUrl: snapshot
                                          .data!.results![index].posterPath ??
                                      "",
                                  overview:
                                      snapshot.data!.results![index].overview ??
                                          "",
                                  voteAverage: snapshot
                                          .data!.results![index].voteAverage ??
                                      0);
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.arrow_back_outlined),
          ),
          const SizedBox(height: 10), // 加入間距
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.arrow_forward_outlined),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue, // 設定背景色為藍色
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Page $_counter",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white), // 文字顏色設為白色
              ),
            ],
          ),
        ),
      ),
    );
  }
}
