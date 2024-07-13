import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habittracker_flutter/models/habit.dart';
import 'package:habittracker_flutter/database/habit_database.dart';
// components & utils
import 'package:habittracker_flutter/components/my_drawer.dart';
import 'package:habittracker_flutter/utils/habit_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // read existing habits on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  // floating action button method
  TextEditingController textController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Create a new habit'),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              // save new habit name
              String newHabit = textController.text;
              context.read<HabitDatabase>().addHabit(newHabit);
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: const MyDrawer(),
      body: _buildHabitList(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  // build a list of habits for UI
  Widget _buildHabitList() {
    // read the database
    final habitDatabase = context.watch<HabitDatabase>();

    // current db
    List<Habit> currentHabits = habitDatabase.currentHabits;

    // return list using builder
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        return;
      },
    );
  }
}
