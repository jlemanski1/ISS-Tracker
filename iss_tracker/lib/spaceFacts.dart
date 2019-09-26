import 'dart:convert';
import 'dart:io';
/*
International Space Station Size & Mass

    Pressurized Module Length: 167.3 feet (73 meters)
    Truss Length: 357.5 feet (109 meters)
    Solar Array Length: 239.4 feet (73 meters)
    Mass: 925,335 pounds (419,725 kilograms)
    Habitable Volume: 13,696 cubic feet (388 cubic meters) not including visiting vehicles
    Pressurized Volume: 32,333 cubic feet (916 cubic meters)
    With BEAM expanded: 32,898 cubic feet (932 cubic meters)
    Power Generation: 8 solar arrays provide 75 to 90 kilowatts of power
    Lines of Computer Code: approximately 2.3 million
*/

class Facts {
  List<String> facts;

  Facts({this.facts});

  factory Facts.fromJson(Map<String,dynamic> json) => Facts(
    facts: List<String>.from(json["Facts"].map((x) => x))
  );

  // TODO: FUNCTIONS below
  // Parse into list from file
  // Get random fact from list
  // 

}

