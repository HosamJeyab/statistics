import 'package:flutter/material.dart';

class BuildStatCard extends StatelessWidget {
  final String name;
  final int points;
  final int play;
  final int wins;
  final int draw;
  final int loses;
  final int forhim;
  final int onhim;
  final int theDifference;
  final VoidCallback onEdit;
  final VoidCallback onDelete; // إضافة callback لحذف اللاعب

  BuildStatCard({
    required this.name,
    required this.points,
    required this.play,
    required this.wins,
    required this.draw,
    required this.loses,
    required this.forhim,
    required this.onhim,
    required this.theDifference,
    required this.onEdit,
    required this.onDelete, // تمرير onDelete في الكونستركتور
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color.fromARGB(255, 45, 131, 201),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete, // استدعاء onDelete عند الضغط على الزر
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: Colors.white),
              _buildStatRow("لعب", play.toString()),
              _buildStatRow("فاز", wins.toString()),
              _buildStatRow("تعادل", draw.toString()),
              _buildStatRow("خسارة", loses.toString()),
              _buildStatRow("له", forhim.toString()),
              _buildStatRow("عليه", onhim.toString()),
              _buildStatRow("الفرق", theDifference.toString()),
              _buildStatRow("النقاط", points.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
