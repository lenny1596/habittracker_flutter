import 'package:flutter/material.dart';
import 'package:habittracker_flutter/models/app_settings.dart';
import 'package:habittracker_flutter/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

/*
   S E T U P
*/

  // intialize db
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // save initial date of app startup
  Future<void> saveLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..initLaunchDate = DateTime.now();
      await isar.writeTxn(
        () => isar.appSettings.put(settings),
      );
    }
  }

  // get initial date of app startup
  Future<DateTime?> getLauchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.initLaunchDate;
  }

/*
  C R U D - O P E R A T I O N S
*/

  /* List of habits */
  final List<Habit> currentHabits = [];

  /* Add new habits */
  Future<void> addHabit(String habitName) async {
    // create new habit
    final newHabit = Habit()..name = habitName;

    // add habit to db
    await isar.writeTxn(
      () => isar.habits.put(newHabit),
    );
    // re-render from db
    readHabits();
  }

  /* Read Habits */
  Future<void> readHabits() async {
    // fetch all habits in db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // pass it to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    // update UI
    notifyListeners();
  }

  /* Update Habits (check if completion is on or off) */
  Future<void> updateOnHabitCompletion(int id, bool isCompleted) async {
    // get the update's id
    final habit = await isar.habits.get(id);

    // check & update completion
    if (habit != null) {
      await isar.writeTxn(
        () async {
          // if habit is completed, add current date to completedDays list
          if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
            final today = DateTime.now();
            habit.completedDays.add(
              DateTime(today.year, today.month, today.day),
            );
          } else {
            // if habit is not completed, remove current date from list
            habit.completedDays.removeWhere(
              (date) =>
                  date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day,
            );
          }
          // pass updated habit to db
          await isar.habits.put(habit);
        },
      );
    }
    // re-render habits
    readHabits();
  }

  /* Update Habits (update habit name) */
  Future<void> updateHabitName(int id, String newName) async {
    // get update's id
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        // save updated habit  to db
        await isar.habits.put(habit);
      });
    }
    // re-render habits
    readHabits();
  }

  /* Delete Habits */
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(
      () async {
        await isar.habits.delete(id);
      },
    );
    readHabits();
  }
}
