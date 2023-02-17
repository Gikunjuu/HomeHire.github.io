import 'package:flutter/material.dart';

void main() => runApp(Occupancy());

class Occupancy extends StatefulWidget {
  @override
  _OccupancyState createState() => _OccupancyState();
}

class _OccupancyState extends State<Occupancy> {
  int _hostelCapacity = 0;
  List<int> _roomsOccupied = List.filled(12, 0);
  double _occupancyRate = 0.0;

  void _calculateOccupancyRate() {
    int totalRoomsOccupied = 0;
    for (int i = 0; i < 12; i++) {
      totalRoomsOccupied += _roomsOccupied[i];
    }
    _occupancyRate = (totalRoomsOccupied / _hostelCapacity * 12) / 100;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculate Occupancy Rate'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter hostel capacity',
                ),
                onChanged: (value) {
                  setState(() {
                    _hostelCapacity = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText:
                              'Enter number of rooms occupied in month ${index + 1}',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _roomsOccupied[index] = int.parse(value);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: Text('Calculate Occupancy Rate'),
                onPressed: () {
                  setState(() {
                    _calculateOccupancyRate();
                  });
                },
              ),
              const SizedBox(height: 10),
              Text('Occupancy rate: $_occupancyRate%'),
            ],
          ),
        ),
      ),
    );
  }
}
