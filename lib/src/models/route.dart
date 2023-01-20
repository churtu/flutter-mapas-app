import 'dart:convert';

class Route {
    Route({
        required this.countryCrossed,
        required this.weightName,
        required this.weight,
        required this.duration,
        required this.distance,
        required this.legs,
        required this.geometry,
    });

    final bool? countryCrossed;
    final String? weightName;
    final double? weight;
    final double? duration;
    final double? distance;
    final List<Leg?>? legs;
    final String? geometry;

    factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Route.fromMap(Map<String, dynamic> json) => Route(
        countryCrossed: json["country_crossed"],
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: json["legs"] == null ? [] : List<Leg?>.from(json["legs"]!.map((x) => Leg.fromMap(x))),
        geometry: json["geometry"],
    );

    Map<String, dynamic> toMap() => {
        "country_crossed": countryCrossed,
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": legs == null ? [] : List<dynamic>.from(legs!.map((x) => x!.toMap())),
        "geometry": geometry,
    };
}

class Leg {
    Leg({
        required this.viaWaypoints,
        required this.annotation,
        required this.admins,
        required this.weight,
        required this.duration,
        required this.steps,
        required this.distance,
        required this.summary,
    });

    final List<dynamic>? viaWaypoints;
    final Annotation? annotation;
    final List<Admin?>? admins;
    final double? weight;
    final double? duration;
    final List<Step?>? steps;
    final double? distance;
    final String? summary;

    factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        viaWaypoints: json["via_waypoints"] == null ? [] : List<dynamic>.from(json["via_waypoints"]!.map((x) => x)),
        annotation: json["annotation"] == null ? null : Annotation.fromMap(json["annotation"]),
        admins: json["admins"] == null ? [] : List<Admin?>.from(json["admins"]!.map((x) => Admin.fromMap(x))),
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        steps: json["steps"] == null ? [] : List<Step?>.from(json["steps"]!.map((x) => Step.fromMap(x))),
        distance: json["distance"].toDouble(),
        summary: json["summary"],
    );

    Map<String, dynamic> toMap() => {
        "via_waypoints": viaWaypoints == null ? [] : List<dynamic>.from(viaWaypoints!.map((x) => x)),
        "annotation": annotation!.toMap(),
        "admins": admins == null ? [] : List<dynamic>.from(admins!.map((x) => x!.toMap())),
        "weight": weight,
        "duration": duration,
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x!.toMap())),
        "distance": distance,
        "summary": summary,
    };
}

class Admin {
    Admin({
        required this.iso31661Alpha3,
        required this.iso31661,
    });

    final String? iso31661Alpha3;
    final String? iso31661;

    factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
    );

    Map<String, dynamic> toMap() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
    };
}

class Annotation {
    Annotation({
        required this.duration,
    });

    final List<double?>? duration;

    factory Annotation.fromJson(String str) => Annotation.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Annotation.fromMap(Map<String, dynamic> json) => Annotation(
        duration: json["duration"] == null ? [] : List<double?>.from(json["duration"]!.map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "duration": duration == null ? [] : List<dynamic>.from(duration!.map((x) => x)),
    };
}

class Step {
    Step({
        required this.intersections,
        required this.maneuver,
        required this.name,
        required this.duration,
        required this.distance,
        required this.drivingSide,
        required this.weight,
        required this.mode,
        required this.geometry,
        required this.ref,
    });

    final List<Intersection?>? intersections;
    final Maneuver? maneuver;
    final String? name;
    final double? duration;
    final double? distance;
    final String? drivingSide;
    final double? weight;
    final String? mode;
    final String? geometry;
    final String? ref;

    factory Step.fromJson(String str) => Step.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Step.fromMap(Map<String, dynamic> json) => Step(
        intersections: json["intersections"] == null ? [] : List<Intersection?>.from(json["intersections"]!.map((x) => Intersection.fromMap(x))),
        maneuver: Maneuver.fromMap(json["maneuver"]),
        name: json["name"],
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        drivingSide: json["driving_side"],
        weight: json["weight"].toDouble(),
        mode: json["mode"],
        geometry: json["geometry"],
        ref: json["ref"],
    );

    Map<String, dynamic> toMap() => {
        "intersections": intersections == null ? [] : List<dynamic>.from(intersections!.map((x) => x!.toMap())),
        "maneuver": maneuver!.toMap(),
        "name": name,
        "duration": duration,
        "distance": distance,
        "driving_side": drivingSide,
        "weight": weight,
        "mode": mode,
        "geometry": geometry,
        "ref": ref,
    };
}

class Intersection {
    Intersection({
        required this.bearings,
        required this.entry,
        required this.mapboxStreetsV8,
        required this.isUrban,
        required this.adminIndex,
        required this.out,
        required this.geometryIndex,
        required this.location,
        required this.intersectionIn,
        required this.duration,
        required this.turnWeight,
        required this.turnDuration,
        required this.weight,
        required this.trafficSignal,
    });

    final List<int?>? bearings;
    final List<bool?>? entry;
    final MapboxStreetsV8? mapboxStreetsV8;
    final bool? isUrban;
    final int? adminIndex;
    final int? out;
    final int? geometryIndex;
    final List<double?>? location;
    final int? intersectionIn;
    final double? duration;
    final double? turnWeight;
    final double? turnDuration;
    final double? weight;
    final bool? trafficSignal;

    factory Intersection.fromJson(String str) => Intersection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Intersection.fromMap(Map<String, dynamic> json) => Intersection(
        bearings: json["bearings"] == null ? [] : List<int?>.from(json["bearings"]!.map((x) => x)),
        entry: json["entry"] == null ? [] : List<bool?>.from(json["entry"]!.map((x) => x)),
        mapboxStreetsV8: json["mapbox_streets_v8"] == null ? null : MapboxStreetsV8.fromMap(json["mapbox_streets_v8"]),
        isUrban: json["is_urban"],
        adminIndex: json["admin_index"],
        out: json["out"],
        geometryIndex: json["geometry_index"],
        location: json["location"] == null ? [] : List<double?>.from(json["location"]!.map((x) => x.toDouble())),
        intersectionIn: json["in"],
        duration: json["duration"]?.toDouble(),
        turnWeight: json["turn_weight"]?.toDouble(),
        turnDuration: json["turn_duration"],
        weight: json["weight"]?.toDouble(),
        trafficSignal: json["traffic_signal"],
    );

    Map<String, dynamic> toMap() => {
        "bearings": bearings == null ? [] : List<dynamic>.from(bearings!.map((x) => x)),
        "entry": entry == null ? [] : List<dynamic>.from(entry!.map((x) => x)),
        "mapbox_streets_v8": mapboxStreetsV8,
        "is_urban": isUrban,
        "admin_index": adminIndex,
        "out": out,
        "geometry_index": geometryIndex,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "in": intersectionIn,
        "duration": duration,
        "turn_weight": turnWeight,
        "turn_duration": turnDuration,
        "weight": weight,
        "traffic_signal": trafficSignal,
    };
}

class MapboxStreetsV8 {
    MapboxStreetsV8({
        required this.mapboxStreetsV8Class,
    });

    final Class? mapboxStreetsV8Class;

    factory MapboxStreetsV8.fromJson(String str) => MapboxStreetsV8.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MapboxStreetsV8.fromMap(Map<String, dynamic> json) => MapboxStreetsV8(
        mapboxStreetsV8Class: classValues.map[json["class"]],
    );

    Map<String, dynamic> toMap() => {
        "class": classValues.reverse![mapboxStreetsV8Class],
    };
}

enum Class { street, primary }

final classValues = RouteEnumValues({
    "primary": Class.primary,
    "street": Class.street
});

class Maneuver {
    Maneuver({
        required this.type,
        required this.instruction,
        required this.bearingAfter,
        required this.bearingBefore,
        required this.location,
        required this.modifier,
    });

    final String? type;
    final String? instruction;
    final int? bearingAfter;
    final int? bearingBefore;
    final List<double?>? location;
    final String? modifier;

    factory Maneuver.fromJson(String str) => Maneuver.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Maneuver.fromMap(Map<String, dynamic> json) => Maneuver(
        type: json["type"],
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: json["location"] == null ? [] : List<double?>.from(json["location"]!.map((x) => x.toDouble())),
        modifier: json["modifier"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "modifier": modifier,
    };
}

class Waypoint {
    Waypoint({
        required this.distance,
        required this.name,
        required this.location,
    });

    final double? distance;
    final String? name;
    final List<double?>? location;

    factory Waypoint.fromJson(String str) => Waypoint.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Waypoint.fromMap(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: json["location"] == null ? [] : List<double?>.from(json["location"]!.map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "distance": distance,
        "name": name,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    };
}

class RouteEnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    RouteEnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
