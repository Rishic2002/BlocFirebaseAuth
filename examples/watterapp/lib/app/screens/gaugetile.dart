// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../app/bloc/app_bloc.dart';
import '../theme/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  static Page<void> page() => MaterialPage<void>(child: HomePage());
}

class _HomePageState extends State<HomePage> {
  final headers = {
    'Content-Type': 'application/vnd.flux',
    'Authorization':
        'Bearer IIMIPUCl2QApy9Do8Fkf1wN9TjJc1ylORMgmgSkQesSlgxD3ctdP6_G1odd6wuJfJ9QwBPwSkZff26KRck3CDw=='
  };
  final query = '''from(bucket: "ADARSHARYA")
|> range(start: -2m)
|> filter(fn: (r) => r["_measurement"] == "adarsharya")
|> filter(fn: (r) => r["_field"] == "TankFilledPercent")
|> filter(fn: (r) => r["TankId"] =~ /^TankBlock/)
|> group(columns: ["TankId"])
|> last()
|> keep(columns: ["_time", "_value", "TankId"])
''';

  Future<List<List<dynamic>>> _getData() async {
    final request = http.Request(
        'POST',
        Uri.parse(
            'http://3.132.136.107:8086/api/v2/query?org=f8c32d91e068f243&bucket=ADARSHARYA'));
    request.body = query;
    request.headers.addAll(headers);
    final response = await request.send();
    if (response.statusCode == 200) {
      final String responseBody = await response.stream.bytesToString();
      final List<List<dynamic>> data =
          const CsvToListConverter().convert(responseBody);
      data.removeAt(0);
      return data;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotifications() async {
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      // handle notification tap here
    });
  }
Future<void> _scheduleNotification(double tankFilledPercent) async {
  // Request permission to display notifications on Android


  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'tank_filled_percent_channel', // channel ID
    'Tank Filled Percent', // channel name
    'Displays the current tank filled percentage every 5 seconds', // channel description
    importance: Importance.high,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound('notification_sound'),
 
  );
  final platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await FlutterLocalNotificationsPlugin().zonedSchedule(
      0,
      'Tank Filled Percent',
      '${tankFilledPercent.toStringAsFixed(2)}% full',
      _nextInstanceOfFiveSeconds(),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'tank_filled_percent');
}

tz.TZDateTime _nextInstanceOfFiveSeconds() {
  final now = tz.TZDateTime.now(tz.local);
  return now.add(const Duration(seconds: 5));
}


  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.email ?? '', style: textTheme.titleLarge),
      ),
      
      body: FutureBuilder<List<List<dynamic>>>(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<List<dynamic>> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final row = data[index];
                if (row.length >= 6) {
                  // check the length of row before accessing its values
                  final tankName = row[5].toString();
                  final tankFilledPercent =
                      double.tryParse(row[4].toString()) ?? 0.0;
                  _scheduleNotification(tankFilledPercent);
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.125,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(tankName),
                            subtitle: Text(
                              'Last updated: ${DateFormat.yMd().add_jm().format(DateTime.now())}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: buildGauge(tankFilledPercent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink(); // or return an empty container
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget buildGauge(double value) {
  return SizedBox(
    width: 50,
    child: SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 1000,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: true,
          canScaleToFit: true,
          axisLineStyle: AxisLineStyle(
            thickness: 0.2,
            cornerStyle: CornerStyle.bothCurve,
            color: Colors.blue,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            NeedlePointer(
              value: value,
              enableAnimation: true,
              animationDuration: 1000,
              needleStartWidth: 1,
              needleEndWidth: 5,
              needleColor: Colors.blue,
              knobStyle: KnobStyle(
                knobRadius: 0.07,
                sizeUnit: GaugeSizeUnit.factor,
                color: Colors.white,
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    value.toStringAsFixed(2),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              positionFactor: 0.5,
              angle: 90,
            ),
          ],
        ),
      ],
    ),
  );
}

