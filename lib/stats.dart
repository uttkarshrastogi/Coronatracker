class Stats {
  late final String country;
  late final int confirmed;
  late final int recovered;
  late final int deaths;
  late final int critical;
  late final String id;

  Stats({
    required this.country,
    required this.confirmed,
    required this.recovered,
    required this.deaths,
    required this.critical,
    required this.id,
  });

  factory Stats.fromJson(dynamic json) {
    return new Stats(
      deaths: json['deaths'] as int,
      critical: json['critical'] as int,
      country: json['country'] as String,
      confirmed: json['confirmed'] as int,
      recovered: json['recovered'] as int,
      id: json['code'] as String,
    );
  }
  static List<Stats> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Stats.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Stats{country: $country, confirmed: $confirmed, recovered: $recovered,deaths: $deaths,critical:$critical}';
  }
}
