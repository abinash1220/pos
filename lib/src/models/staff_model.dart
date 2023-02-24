class EmployeeModel {
  
  String name;
  String username;
  String userID;
  DateTime inTime;
  DateTime outTime;
  bool isIn;
  bool isOut;
  List<LatLongModel> inLocation;
  List<LatLongModel> outLocation;

  EmployeeModel(
      {required this.name,
      required this.username,
      required this.userID,
      required this.inTime,
      required this.isIn,
      required this.isOut,
      required this.inLocation,
      required this.outLocation,
      required this.outTime});

  Map<String, dynamic> toJson() => {
        "name": name,
        "userName": username,
        "userID": userID,
        "inTime": outTime.toIso8601String(),
        "outTime": outTime.toIso8601String(),
        "isIn": isIn,
        "isOut": isOut,
        "inLocation":  List<dynamic>.from(inLocation.map((x) => x.toJson())),
        "outLocation":
            List<dynamic>.from(outLocation.map((x) => x.toJson())),
      };
}

class LatLongModel {
  double latitude;
  double longitude;

  LatLongModel({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
