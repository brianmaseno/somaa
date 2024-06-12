// lib/screens/home/mathpage.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somaa/providers/subject_provider.dart';
// import 'package:system_auth/providers/subject_provider.dart';

class MathTopicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Topics'),
        backgroundColor: Colors.brown,
      ),
      body: Consumer<SubjectProvider>(
        builder: (context, subjectProvider, child) {
          if (subjectProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (subjectProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(subjectProvider.errorMessage));
          } else if (subjectProvider.subjects.isEmpty) {
            return const Center(child: Text('No topics found'));
          } else {
            final mathTopics = subjectProvider.subjects
                .where((subject) => subject.name == 'Math')
                .toList();

            return ListView.builder(
              itemCount: mathTopics.length,
              itemBuilder: (context, index) {
                final topic = mathTopics[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    topic.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
