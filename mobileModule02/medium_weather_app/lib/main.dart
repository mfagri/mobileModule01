import 'package:flutter/material.dart';
import 'package:weather_app/tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController searchController = TextEditingController();
  String location = '';

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            controller: searchController,
            style: TextStyle(color: Colors.white),
            onSubmitted: (value) {
              if (value.isEmpty) return;
              setState(() {
                location = value;
              });
              searchController.clear();
            },
            decoration: InputDecoration(
              hintText: 'Search location',
              hintStyle: TextStyle(color: Colors.white70),
              prefixIcon: IconButton(
                onPressed: () {
                  if (searchController.text.isEmpty) return;
                  setState(() {
                    location = searchController.text;
                  });
                  searchController.clear();
                },
                icon: Icon(Icons.search, color: Colors.white),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width: 2.0, color: Colors.white),
          ),
          IconButton(
            icon: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: const Icon(Icons.navigation_rounded, color: Colors.white),
            ),
            onPressed: () {
              searchController.clear();
              location = 'Geolocation';
              setState(() {});
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          TabViewPage(title: 'Currently', subtitle: location),
          TabViewPage(title: 'Today', subtitle: location),
          TabViewPage(title: 'Weekly', subtitle: location),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        elevation: 0,
        color: Colors.white,
        child: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: Colors.blueAccent),
          ),
          dividerColor: Colors.transparent,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
          controller: tabController,
          tabs: [
            Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Currently'),
            Tab(icon: Icon(Icons.calendar_today_outlined), text: 'Today'),
            Tab(icon: Icon(Icons.calendar_month_outlined), text: 'Weekly'),
          ],
        ),
      ),
    );
  }
}
