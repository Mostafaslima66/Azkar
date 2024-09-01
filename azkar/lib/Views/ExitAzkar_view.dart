import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar/Widgets/CustomAzkar_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExitAzkarView extends StatefulWidget {
  const ExitAzkarView({super.key});
  static String id = 'ExitAzkar_view';
  @override
  State<ExitAzkarView> createState() => _ExitAzkarViewState();
}

class _ExitAzkarViewState extends State<ExitAzkarView> {
  // Define a variable to store the retrieved data
  String? myData;
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isNotificationEnabled = false;

  // Override initState to retrieve data when the widget is initialized
  @override
  void initState() {
    super.initState();
    loadData();
    _loadNotificationPreferences();
  }

  //define function for schedule notification
  void _scheduleDailyNotification(TimeOfDay time) {
    AwesomeNotifications().cancel(3);

    if (_isNotificationEnabled) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 3,
          channelKey: 'schedule_channel',
          title: 'وقت الاذكار الان',
          body: 'اذكار الخروج',
        ),
        schedule: NotificationCalendar(
          hour: time.hour,
          minute: time.minute,
          second: 0,
          repeats: true,
        ),
      );
    }
  }

// define the function of selecte time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _saveTimePreference(picked);
        _scheduleDailyNotification(_selectedTime);
      });
    }
  }

  Future<void> _loadNotificationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationEnabled =
          prefs.getBool('exitIsNotificationEnabled') ?? false;
      int? hour = prefs.getInt('exitNotificationHour');
      int? minute = prefs.getInt('exitNotificationMinute');
      if (hour != null && minute != null) {
        _selectedTime = TimeOfDay(hour: hour, minute: minute);
      }
    });
  }

  Future<void> _saveNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('exitIsNotificationEnabled', value);
  }

  Future<void> _saveTimePreference(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('exitNotificationHour', time.hour);
    await prefs.setInt('exitNotificationMinute', time.minute);
  }

  // Define a function to retrieve data from Hive box
  Future<void> loadData() async {
    final box = await Hive.openBox('myBox');
    // Retrieve the value stored with 'myKey'
    final dataList =
        box.get('أذكار الخروج') as List<String>; // Retrieve as a List<String>
    final dataString = dataList.join('\n'); // Join the strings with newlines
    setState(() {
      myData = dataString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/image-from-rawpixel-id-8306864-jpeg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xffefede6),
          title: const Text(
            'اذكار الخروج',
            style: TextStyle(
                color: Color(0xffbd7e4a),
                fontFamily: 'Cairo',
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffbd7e4a),
                size: 30,
              )),
          actions: [
           ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFB58867))),
              onPressed: () => _selectTime(context),
              child: Text(
                ' ${_selectedTime.format(context)}',
                style: const TextStyle(fontSize: 18,color: Colors.white),
              ),
              
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchListTile(
                    inactiveThumbColor: Colors.white,
                   inactiveTrackColor: Color(0xFFB58867),
                    title: const Text(
                      'تفعيل الاشعارات',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffa55e47)),
                    ),
                    value: _isNotificationEnabled,
                    onChanged: (bool value) {
                      setState(() {
                       _isNotificationEnabled = value;
                        _saveNotificationPreference(value);
                        _scheduleDailyNotification(_selectedTime);
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: myData?.length != null ? 1 : 0,
                itemBuilder: (context, index) {
                  return CustomAzkar(
                    thedata: myData.toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
