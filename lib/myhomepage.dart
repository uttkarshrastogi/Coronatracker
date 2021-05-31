import 'package:covidtracker/CoronaCard.dart';
import 'package:covidtracker/stats.dart';
import 'package:covidtracker/stats_api.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String update = "15 min";
  List<Stats>? _stats;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    myController.text = "india";

    getS();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<void> getS() async {
    // ignore: unnecessary_null_comparison

    _stats = await StatsApi.getStats(myController.text);
    setState(() {
      _isLoading = false;
    });
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.coronavirus,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Corona Tracker",
              style: TextStyle(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    color: Colors.white70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onEditingComplete: () {
                          setState(() {
                            getS();

                            update = "a Few minutes";
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          });
                        },
                        controller: myController,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                          labelText: 'Enter the Value',
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          fillColor: Colors.grey,
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: "search a country",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              myController.clear();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Covid-19 Tracker",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              _stats![0].country,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.network(
                              "https://www.countryflags.io/${_stats![0].id.toString()}/flat/32.png"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20, bottom: 10),
                        child: Text(
                          "Last updated $update ago",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CoronaCard(
                              C: Colors.lightBlueAccent,
                              Cname: "CONFIRMED",
                              value: _stats![0].confirmed.toString(),
                            ),
                            CoronaCard(
                                C: Colors.green,
                                Cname: "RECOVERED",
                                value: _stats![0].recovered.toString()),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CoronaCard(
                            C: Colors.redAccent,
                            Cname: "DEATHS",
                            value: _stats![0].deaths.toString(),
                          ),
                          CoronaCard(
                              C: Colors.black54,
                              Cname: "CRITICAL",
                              value: _stats![0].critical.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
