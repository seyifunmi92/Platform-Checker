import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      accentColor: Colors.white10,
      primaryColor: Colors.white,
      brightness: Brightness.light,
    ),
      home: const MyPlatform(),

  ));
}
class MyPlatform extends StatefulWidget {
  const MyPlatform({Key? key}) : super(key: key);
  @override
  _MyPlatformState createState() => _MyPlatformState();
}
class _MyPlatformState extends State<MyPlatform> {
  bool isonIOS = false;
  bool isonAndroid = false;
  bool isonMacOS = true;
  bool isonLinux = true;
  bool isonWindows = true;
  bool isonWeb = true;
  String ErrorText = "Failed to get Platform Info";
  static DeviceInfoPlugin mydevicedata = DeviceInfoPlugin();
  final Map<String, dynamic> _devicedata = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    PlatformChecker();
  }
  Future<void> PlatformChecker() async {
    //var devicedata = _devicedata;
    var devicedata = <String, dynamic>{};
    try {
      if (kIsWeb) {
        setState(() {
          isonWeb = true;
        });
        devicedata = browserInfo(await mydevicedata.webBrowserInfo);
      } else if (Platform.isIOS) {
        setState(() {
          isonIOS = true;
        });
        devicedata = iOSInfo(await mydevicedata.iosInfo);
      } else if (Platform.isWindows) {
        setState(() {
          isonWindows = true;
        });
        devicedata = windowsInfo(await mydevicedata.windowsInfo);
      } else if (Platform.isAndroid) {
        setState(() {});
        devicedata = androidInfo(await mydevicedata.androidInfo);
      } else if (Platform.isMacOS) {
        setState(() {
          isonMacOS = true;
        });
        devicedata = macOsInfo(await mydevicedata.macOsInfo);
      } else if (Platform.isLinux) {
        setState(() {
          isonLinux = true;
        });
        devicedata = LinuxInfo(await mydevicedata.linuxInfo);
      }
    } on Exception {
      devicedata = <String, dynamic>{
        "Error": ErrorText,
      };
    }
    if (!mounted) {
      return setState(() {
        mydevicedata = devicedata as DeviceInfoPlugin;
      });
    }
    // Map<String, dynamic> browserInfo(){}
    // iOSInfo(){}
  }
  Map<String, dynamic> browserInfo(WebBrowserInfo mydata) {
    return <String, dynamic>{
      "browserName": describeEnum(mydata.browserName),
      "appName": mydata.appName,
      "appVersion": mydata.appVersion,
      "platform": mydata.platform,
    };
  }
  Map<String, dynamic> iOSInfo(IosDeviceInfo mydata) {
    return <String, dynamic>{"name": mydata.name, "model": mydata.model};
  }

  Map<String, dynamic> windowsInfo(WindowsDeviceInfo mydata) {
    return <String, dynamic>{
      "computerName": mydata.computerName,
    };
  }
  Map<String, dynamic> androidInfo(AndroidDeviceInfo mydata) {
    return <String, dynamic>{
      "model": mydata.model,
      "id": mydata.id,
      "device": mydata.device,
    };
  }
  Map<String, dynamic> macOsInfo(MacOsDeviceInfo mydata) {
    return <String, dynamic>{
      "model": mydata.model,
      "osRelease": mydata.osRelease,
      "computerName": mydata.computerName,
    };
  }
  Map<String, dynamic> LinuxInfo(LinuxDeviceInfo mydata) {
    return <String, dynamic>{
      "name": mydata.name,
      "id": mydata.id,
      // "device" : mydata.device,
    };
  }
  // @override
  // Widget build(BuildContext context) {
  //
  //   //throw UnimplementedError();
  //   return Scaffold(
  //     body: Text("Seyi"),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          kIsWeb
              ? const Text(" This Shows for a Web")
              : Platform.isAndroid
              ? const Text("This will show for all Android devices")
              : Platform.isIOS
              ? const Text("This will show for IOS devices")
              : Platform.isLinux
              ? const Text("This will show for Linux Devices")
              : Platform.isWindows
              ? const Text("This will show for Windows devices")
              : Platform.isMacOS
              ? const Text(
              "This will show for Mac OS devices")
              : const Text(""),

          Platform.isIOS ? Container(color: Colors.black12,) :
              Platform.isAndroid ? Container(color: Colors.blue,
              child: const Text(""),)
                  : Container(color: Colors.amber,),
        ],
      ),
    );
  }
}

// class Check extends StatefulWidget {
//   const Check({Key? key}) : super(key: key);
//
//   @override
//   _CheckState createState() => _CheckState();
// }
//
// class _CheckState extends State<Check> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
