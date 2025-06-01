import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

// मुख्य ऐप विजेट
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'डेमो लिस्ट ऐप',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: HomeScreen(),
      home: PaginatedListDemo(),
    );
  }
}

// होम स्क्रीन जहाँ API कॉल और लिस्टव्यू होगा
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// होम स्क्रीन जहाँ API कॉल और लिस्टव्यू होगा
class PaginatedListDemo extends StatefulWidget {
  @override
  _PaginatedListDemoState createState() => _PaginatedListDemoState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> dataList = [];

  // API से डेटा लाने वाला फंक्शन
  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        dataList = json.decode(response.body);
      });
    } else {
      throw Exception('डेटा लोड करने में त्रुटि');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // ऐप शुरू होते ही API कॉल करें
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('डेमो लिस्ट व्यू'),
      ),
      body: dataList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final item = dataList[index];
          return ListTile(
            title: Text(item['title']),
            subtitle: Text(item['body']),
          );
        },
      ),
    );
  }
}

class _PaginatedListDemoState extends State<PaginatedListDemo> {
  List<String> items = [];
  int page = 0;
  final int pageSize = 20;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 && !isLoading &&
          hasMore) {
        fetchItems();
      }
    });
  }

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    List<String> newItems = List.generate(
      pageSize,
          (index) => 'Item ${(page * pageSize) + index + 1}',
    );

    setState(() {
      page++;
      items.addAll(newItems);
      isLoading = false;

      // Simulate end of data
      if (page >= 5) {
        hasMore = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildLoader() {
    return isLoading
        ? const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(child: CircularProgressIndicator()),
    )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination Demo')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return ListTile(
              title: Text(items[index]),
            );
          } else {
            return buildLoader();
          }
        },
      ),
    );
  }
}