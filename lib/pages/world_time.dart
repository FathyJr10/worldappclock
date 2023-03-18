import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location = '';
  String time = '';
  String flag = '';
  String url = '';
  bool isDaytime = false;

  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    var response =
        await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
    //set time to string 3ashan ehna bnakhod el time bnkhleeh datetime type
    time = DateFormat.jm().format(now);
  }
}
