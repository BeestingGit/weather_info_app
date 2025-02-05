import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 7,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');

    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: 0,
      length: 7,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    tabIndex.dispose();

    super.dispose();
  }

  // Random function to generate a temperature between 20 and 60
  int _generateRandomTemperature() {
    Random random = Random();
    return 20 + random.nextInt(41);
  }

  // List of random weather conditions
  List<String> _weatherConditions = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Windy',
    'Snowy',
    'Stormy',
  ];

  String _generateRandomCondition() {
    Random random = Random();
    return _weatherConditions[random.nextInt(_weatherConditions.length)];
  }

  @override
  Widget build(BuildContext context) {
// For the ToDo task hint: consider defining the widget and name of the tabs here

    final tabs = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Weather App',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
// hint for the to do task:Considering creating the different for different tabs

          for (final tab in tabs)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Weather Info for $tab', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 10),
                  Text('Temperature: ${_generateRandomTemperature()}°C'),
                  Text('Condition: ${_generateRandomCondition()}'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
