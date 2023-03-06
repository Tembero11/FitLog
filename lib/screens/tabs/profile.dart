import 'package:flutter/material.dart';
import 'package:gym_diary/utils/data/database.dart';
import 'package:gym_diary/utils/data/models/question.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  late final SqliteDatabase _database;

  late Future<List<QuestionModel>> _questions;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _database = SqliteDatabase();
    _questions = _database.getQuestions();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
    super.initState();
  }

  Future<void> _refresh() async {
    final list = _database.getQuestions();
    setState(() {
      _questions = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _database.insertQuestion(QuestionModel(id: (await _questions).length, question: "Are you okay?"));
          _refreshIndicatorKey.currentState!.show();
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder<List<QuestionModel>>(
          future: _questions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) async {},
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  QuestionModel question = snapshot.data![index];
                  return Dismissible(
                    key: Key(question.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(color: Colors.red),
                    onDismissed: (direction) async {
                      await _database.deleteQuestion(index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${question.id} dismissed')));
                      _refreshIndicatorKey.currentState!.show();
                    },
                    child: Container(
                      height: 60,
                      color: Colors.grey.shade100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(question.id.toString()),
                          Text('${question.question} ${question.icon}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 40),
                  const Text("Unable to load questions."),
                  TextButton(
                    onPressed: () => _refreshIndicatorKey.currentState!.show(),
                    child: const Text("Refresh"),
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
