// To parse this JSON data, do
//
//     final trafficResponse = trafficResponseFromMap(jsonString);

import 'package:mapas_app/src/models/models.dart';
import 'dart:convert';

class TrafficResponse {
    TrafficResponse({
        required this.routes,
        required this.waypoints,
        required this.code,
        required this.uuid,
    });

    final List<Route?>? routes;
    final List<Waypoint?>? waypoints;
    final String? code;
    final String? uuid;

    factory TrafficResponse.fromJson(String str) => TrafficResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TrafficResponse.fromMap(Map<String, dynamic> json) => TrafficResponse(
        routes: json["routes"] == null ? [] : List<Route?>.from(json["routes"]!.map((x) => Route.fromMap(x))),
        waypoints: json["waypoints"] == null ? [] : List<Waypoint?>.from(json["waypoints"]!.map((x) => Waypoint.fromMap(x))),
        code: json["code"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toMap() => {
        "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x!.toMap())),
        "waypoints": waypoints == null ? [] : List<dynamic>.from(waypoints!.map((x) => x!.toMap())),
        "code": code,
        "uuid": uuid,
    };
}


