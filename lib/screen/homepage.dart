import 'package:flutter/material.dart';
import 'package:statistics/widget/carwidget.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BuildStatCard> players = [];

  void _addPlayer() {
    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        return AlertDialog(
          title: Text("إضافة لاعب جديد"),
          content: TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: InputDecoration(hintText: "اسم اللاعب"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  setState(() {
                    players.add(BuildStatCard(
                      name: name,
                      points: 0,
                      wins: 0,
                      loses: 0,
                      draw: 0,
                      forhim: 0,
                      onhim: 0,
                      theDifference: 0,
                      play: 0,
                      onEdit: () => _editPlayer(players.length - 1),
                      onDelete: () => _deletePlayer(players.length - 1),
                    ));
                  });
                }
                Navigator.pop(context);
              },
              child: Text("إضافة"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("إلغاء"),
            ),
          ],
        );
      },
    );
  }

  void _editPlayer(int index) {
    showDialog(
      context: context,
      builder: (context) {
        int wins = players[index].wins;
        int draws = players[index].draw;
        int loses = players[index].loses;
        int goalsFor = players[index].forhim;
        int goalsAgainst = players[index].onhim;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("تعديل إحصائيات اللاعب"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCounter("الفوز", wins, (val) {
                    setDialogState(() => wins = val);
                  }),
                  _buildCounter("تعادل", draws, (val) {
                    setDialogState(() => draws = val);
                  }),
                  _buildCounter("الخسارة", loses, (val) {
                    setDialogState(() => loses = val);
                  }),
                  _buildCounter("له", goalsFor, (val) {
                    setDialogState(() => goalsFor = val);
                  }),
                  _buildCounter("عليه", goalsAgainst, (val) {
                    setDialogState(() => goalsAgainst = val);
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      int play = wins + loses + draws;
                      int score = wins * 3 + draws;
                      players[index] = BuildStatCard(
                        name: players[index].name,
                        points: score,
                        wins: wins,
                        draw: draws,
                        loses: loses,
                        forhim: goalsFor,
                        onhim: goalsAgainst,
                        theDifference: (goalsFor - goalsAgainst),
                        play: play,
                        onEdit: () => _editPlayer(index),
                        onDelete: () => _deletePlayer(index),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: Text("حفظ"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("إلغاء"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 18)),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (value > 0) {
                  onChanged(value - 1);
                  setState(() {});
                }
              },
            ),
            Text(value.toString(), style: TextStyle(fontSize: 18)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                onChanged(value + 1);
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  void _deletePlayer(int index) {
    setState(() {
      players.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FIFA League Statistics",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FloatingActionButton(
            onPressed: _addPlayer,
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 45, 131, 201),
          ),
        ],
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 2, 38, 92),
                Color.fromARGB(255, 45, 131, 201),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 2, 38, 92),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: players.length,
          itemBuilder: (context, index) {
            return players[index];
          },
        ),
      ),
    );
  }
}
