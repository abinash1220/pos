import 'package:background_location/background_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:pos/src/const/firebase_consts.dart';
import 'package:pos/src/models/staff_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationAndFirebaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> polyLocation = [];

  enableLocationServices() async {
    polyLocation.clear();
    await BackgroundLocation.setAndroidNotification(
      title: 'Your in',
      message: 'location monitoring',
      icon: '@mipmap/ic_launcher',
    );
    // await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(distanceFilter: 10);
    BackgroundLocation.getLocationUpdates((location) {
      print(
          ":::::::::::::::location ${location.latitude}  ${location.longitude}");
      polyLocation.add(
          {"latitude": location.latitude, "longitude": location.longitude});

      updateLiveLocation(
          latLongModel: LatLongModel(
              latitude: location.latitude ?? 0,
              longitude: location.longitude ?? 0));
      updateLivePolyLines(polyLocation: polyLocation);
    });
  }

  stopLocationServices() {
    BackgroundLocation.stopLocationService();
  }

  addUser(EmployeeModel employeeModel) {
    CollectionReference employeee =
        FirebaseFirestore.instance.collection(employeeCollection);

    employeee
        .add(employeeModel.toJson())
        .then((value) => print("User Added....."))
        .catchError((error) => print("Failed to add user: $error...."));
  }

  dailyAttendance(EmployeeModel employeeModel) async {
    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    attendanceCollection
        .doc(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
        .collection(emplyeeAttendanceCollection)
        .doc(employeeModel.username)
        .set(employeeModel.toJson())
        .then((value) {
      Get.snackbar(
          "Your IN Now", "Don't kill the app while its running in background",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) => print("Failed to add user: $error...."));
  }

  markAsIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");

    loc.Location location = loc.Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    EmployeeModel employeeModel = EmployeeModel(
        name: username ?? "",
        username: username ?? "",
        userID: username ?? "",
        inTime: DateTime.now(),
        isIn: true,
        isOut: false,
        inLocation: [
          LatLongModel(
              latitude: _locationData.latitude ?? 0,
              longitude: _locationData.longitude ?? 0)
        ],
        outLocation: [],
        outTime: DateTime.now());

    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    attendanceCollection
        .doc(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
        .collection(emplyeeAttendanceCollection)
        .doc(employeeModel.username)
        .set(employeeModel.toJson())
        .then((value) {
      enableLocationServices();
      Get.snackbar("Your IN Now", "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) => print("Failed to add user: $error...."));
  }

  updateLiveLocation({required LatLongModel latLongModel}) async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");

    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    attendanceCollection
        .doc(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
        .collection(emplyeeAttendanceCollection)
        .doc(username)
        .collection(liveLOcationCollection)
        .doc("live")
        .set(latLongModel.toJson())
        .then((value) {
      print(
          "............................location is changeing...........................");
    }).catchError((error) => print("Failed to add user: $error...."));
  }

  updateLivePolyLines(
      {required List<Map<String, dynamic>> polyLocation}) async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");

    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    attendanceCollection
        .doc(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
        .collection(emplyeeAttendanceCollection)
        .doc(username)
        .collection(liveLOcationCollection)
        .doc("livepolyline")
        .set({"polyLine": polyLocation}).then((value) {
      print(
          "............................poly line  is changeing...........................");
    }).catchError((error) => print("Failed to add user: $error...."));
  }

  markAsOut() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");

    loc.Location location = loc.Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    EmployeeModel employeeModel = EmployeeModel(
        name: username ?? "",
        username: username ?? "",
        userID: username ?? "",
        inTime: DateTime.now(),
        isIn: true,
        isOut: false,
        inLocation: [
          LatLongModel(
              latitude: _locationData.latitude ?? 0,
              longitude: _locationData.longitude ?? 0)
        ],
        outLocation: [
          LatLongModel(
              latitude: _locationData.latitude ?? 0,
              longitude: _locationData.longitude ?? 0)
        ],
        outTime: DateTime.now());

    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    attendanceCollection
        .doc(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
        .collection(emplyeeAttendanceCollection)
        .doc(employeeModel.username)
        .update({
      "outLocation": [
        {
          "latitude": _locationData.latitude ?? 0,
          "longitude": _locationData.longitude ?? 0,
        }
      ],
      "isOut": true,
      "outTime": DateTime.now().toIso8601String()
    }).then((value) {
      stopLocationServices();
      Get.snackbar("Your Out Now", "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) => print("Failed to add user: $error...."));
  }

  checkIfTheUserIsAvailable() async {
    final prefs = await SharedPreferences.getInstance();

    CollectionReference employeee =
        FirebaseFirestore.instance.collection(employeeCollection);
    String? username = prefs.getString("username");

    var employee =
        await employeee.where("userName", isEqualTo: username?.trim()).get();
    print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
    print(employee.docs.length);
    if (employee.docs.isEmpty) {
      print(
          ":::::::::::::::::::::::::this is a new employeeeeee::::::::::::::");
      EmployeeModel employeeModel = EmployeeModel(
          name: username ?? "",
          username: username ?? "",
          userID: username ?? "",
          inTime: DateTime.now(),
          isIn: true,
          isOut: false,
          inLocation: [],
          outLocation: [],
          outTime: DateTime.now());

      addUser(employeeModel);
    } else {
      print(":::::::::::::::::::old Employeeee:::::::::::::::");
    }
  }

  Future<List<EmployeeModel>> generateUserHistory(
      String username, DateTime date) async {
    List<EmployeeModel> tempHistoryList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(dailyAttendanceCollection)
        .doc("${date.day}-${date.month}-${date.year}")
        .collection(emplyeeAttendanceCollection)
        .where("userName", isEqualTo: username)
        .get();
    tempHistoryList.clear();
    print("__________-------${querySnapshot.docs.length}----$date--__________");
    for (var doc in querySnapshot.docs) {
      EmployeeModel employeeModel = EmployeeModel(
        name: doc["name"],
        username: doc["userName"],
        userID: doc["userID"],
        outTime: DateTime.parse(doc["outTime"]),
        inLocation: List<LatLongModel>.from(doc["inLocation"].map((x) =>
            LatLongModel(latitude: x["latitude"], longitude: x["longitude"]))),
        inTime: DateTime.parse(doc["inTime"]),
        isIn: doc["isIn"],
        isOut: doc["isOut"],
        outLocation: List<LatLongModel>.from(doc["outLocation"].map((x) =>
            LatLongModel(latitude: x["latitude"], longitude: x["longitude"]))),
      );
      tempHistoryList.add(employeeModel);
    }
    return tempHistoryList;
  }
}
