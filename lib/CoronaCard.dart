import 'package:flutter/material.dart';

class CoronaCard extends StatefulWidget {
  late final String value;
  late final String Cname;
  late final Color C;

  CoronaCard({
    required this.value,
    required this.Cname,
    required this.C,
  });

  @override
  _CoronaCardState createState() => _CoronaCardState();
}

class _CoronaCardState extends State<CoronaCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width / 2.8,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: widget.C,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.Cname,
                  style: TextStyle(
                      color: Colors.black, fontSize: 10, letterSpacing: 1.2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.value,
                  style: TextStyle(
                    color: widget.C,
                    fontSize: 19,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
