import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SebhaView extends StatefulWidget {
  const SebhaView({super.key});
  static String id = 'Sebha_view';

  @override
  State<SebhaView> createState() => _SebhaViewState();
}

class _SebhaViewState extends State<SebhaView> {
  final Map<String, int> counters = {}; // Map to store counters for each text option
  int selectedIndex = 0; // Initial selected index
  final List<String> options = [
    'سبحان الله',
    'الحمد لله',
     'لا إله إلا الله',
    'الله أكبر',
    'لا حول ولا قوة إلا بالله',
    'استغفر الله العظيم',
  ]; // List of options

  late PageController _pageController;
  late Box box;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
    openBox();
  }

  Future<void> openBox() async {
    box = await Hive.openBox('sebhabox');
    loadCounters();
  }

  Future<void> loadCounters() async {
    for (String option in options) {
      setState(() {
        counters[option] = box.get(option, defaultValue: 0);
      });
    }
  }

  Future<void> saveCounters() async {
    for (String option in options) {
      await box.put(option, counters[option] ?? 0);
    }
  }

  void addOne() {
    setState(() {
      final selectedText = options[selectedIndex];
      counters[selectedText] = (counters[selectedText] ?? 0) + 1;
      saveCounters(); // Save counters after update
    });
  }

  void reset() {
    setState(() {
      final selectedText = options[selectedIndex];
      counters[selectedText] = 0;
      saveCounters(); // Save counters after update
    });
  }

  void scrollLeft() {
    if (selectedIndex > 0) {
      setState(() {
        selectedIndex--;
      });
      _pageController.animateToPage(selectedIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void scrollRight() {
    if (selectedIndex < options.length - 1) {
      setState(() {
        selectedIndex++;
      });
      _pageController.animateToPage(selectedIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: const Color(0xffEEE3D4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xffefede6),
        title: const Text(
          'السبحه',
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
          const Expanded(child: SizedBox()),
          Expanded(
            child: CircleAvatar(
              radius: isPortrait ? 100 : 50,
              backgroundColor: const Color(0xffbd7e4a),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${counters[options[selectedIndex]] ?? 0}',
                  style: TextStyle(fontSize: isPortrait ? 50 : 25, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: options.length,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        options[index],
                        style: const TextStyle(
                            fontSize: 30,
                            color: Color(0xffbd7e4a),
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  child: IconButton(
                    onPressed: scrollLeft,
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 30, color: Color(0xffbd7e4a)),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: scrollRight,
                    icon: const Icon(Icons.arrow_forward_ios,
                        size: 30, color: Color(0xffbd7e4a)),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        reset();
                      },
                      icon: const Icon(
                        Icons.refresh_outlined,
                        size: 35,
                        color: Color(0xffbd7e4a),
                      )),
                ),
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: IconButton(
                      onPressed: () {
                        addOne();
                      },
                      icon: Icon(
                        Icons.add,
                        size: isPortrait ? 55 : 30,
                        color: const Color(0xffbd7e4a),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xffbd7e4a),
                            title: const Text(
                              'كل التسبيحات',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.right,
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: options.map((option) {
                                  return Text(
                                    '$option: ${counters[option] ?? 0}',
                                    style: const TextStyle(color: Colors.white, fontSize: 20),
                                  );
                                }).toList(),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close', style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.done,
                      size: 35,
                      color: Color(0xffbd7e4a),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
