import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/search_module/components/body.dart';

class search extends StatefulWidget {
  search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: search_body(),
    );
  }
}
