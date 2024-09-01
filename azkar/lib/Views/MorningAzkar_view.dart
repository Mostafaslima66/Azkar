import 'package:azkar/Widgets/CustomAzkar_widget.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorningAzkarView extends StatefulWidget {
  const MorningAzkarView({super.key});
  static String id = 'MorningAzkar_view';
  @override
  State<MorningAzkarView> createState() => _MorningAzkarViewState();
}

class _MorningAzkarViewState extends State<MorningAzkarView> {
  String? myData;
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isNotificationEnabled = false;

  @override
  void initState() {
    super.initState();
    loadData();
    _loadNotificationPreferences();
  }

  void _scheduleDailyNotification(TimeOfDay time) {
    AwesomeNotifications().cancel(1);

    if (_isNotificationEnabled) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,  // Unique ID for morning notification
          channelKey: 'schedule_channel',
          title: 'وقت الاذكار الان',
          body: 'اذكار الصباح',
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
      _isNotificationEnabled = prefs.getBool('morningIsNotificationEnabled') ?? false;
      int? hour = prefs.getInt('morningNotificationHour');
      int? minute = prefs.getInt('morningNotificationMinute');
      if (hour != null && minute != null) {
        _selectedTime = TimeOfDay(hour: hour, minute: minute);
      }
    });
  }

  Future<void> _saveNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('morningIsNotificationEnabled', value);
  }

  Future<void> _saveTimePreference(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('morningNotificationHour', time.hour);
    await prefs.setInt('morningNotificationMinute', time.minute);
  }

  Future<void> loadData() async {
    final box = await Hive.openBox('myBox');
    final dataList = box.get('أذكار الصباح') as List<String>;
    final dataString = dataList.join('\n');
    setState(() {
      myData = dataString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/image-from-rawpixel-id-8306864-jpeg.jpg'),
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
            'اذكار الصباح',
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
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text(
                        ' ${_selectedTime.format(context)}',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFB58867)),
                      ),
                    ),
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
                    onChanged: (bool value) async {
                      if (value) {
                        await _selectTime(context);
                      }
                      setState(() {
                        _isNotificationEnabled = value;
                        _saveNotificationPreference(value);
                        if (value) {
                          _scheduleDailyNotification(_selectedTime);
                        } else {
                          AwesomeNotifications().cancelAllSchedules();
                        }
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
