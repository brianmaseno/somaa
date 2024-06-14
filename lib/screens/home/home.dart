// lib/screens/home/home.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somaa/providers/subject_provider.dart';
import 'package:somaa/providers/user_provider.dart';
import 'package:somaa/screens/home/mathpage.dart';
import 'package:somaa/screens/home/profile/profile.dart';
import 'package:somaa/screens/home/profile/userprofile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AppBar(
            title: const Text(
              'SOMA APP',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserProfile1()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: userProvider.user != null
                            ? const Icon(Icons.person, color: Colors.white)
                            : const CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUserData().then((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user != null) {
        Provider.of<SubjectProvider>(context, listen: false)
            .fetchSubjectsForGrade(userProvider.user!.grade);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectProvider>(
      builder: (context, subjectProvider, child) {
        if (subjectProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (subjectProvider.errorMessage.isNotEmpty) {
          return Center(child: Text(subjectProvider.errorMessage));
        } else if (subjectProvider.subjects.isEmpty) {
          return const Center(child: Text('No subjects found'));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 3 / 2,
            ),
            itemCount: subjectProvider.subjects.length,
            itemBuilder: (context, index) {
              final subject = subjectProvider.subjects[index];
              return GestureDetector(
                onTap: () {
                  if (subject.name == 'Math') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MathTopicsScreen()),
                    );
                  }
                  // Handle other subject taps if needed
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          subject.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                value: subject.progress,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  subject.progress > 0.8
                                      ? Colors.green
                                      : subject.progress > 0.5
                                          ? Colors.blue
                                          : Colors.red,
                                ),
                              ),
                            ),
                            Text(
                              '${(subject.progress * 100).toInt()}%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
