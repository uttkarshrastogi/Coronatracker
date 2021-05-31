import 'package:covidtracker/stats.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsApi {
  static Future<List<Stats>> getStats(String Coun) async {
    String CouN;
    print(Coun);

    CouN = Coun;

    var uri =
        Uri.https('covid-19-data.p.rapidapi.com', '/country', {"name": CouN});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "3621b889f3msh1f67dd4845e7b97p1a6432jsn69f1e453d987",
      "x-rapidapi-host": "covid-19-data.p.rapidapi.com",
      "useQueryString": "true"
    });

    var data = jsonDecode(response.body);

    return Stats.recipesFromSnapshot(data);
  }
}
