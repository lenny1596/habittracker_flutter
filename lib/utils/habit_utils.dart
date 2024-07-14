import 'package:habittracker_flutter/models/habit.dart';

// Method to check if habit was completed today
bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

// Heat map dataset
Map<DateTime, int> heatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      // normalize date to prevent mismatch
      final normalizedDate = DateTime(date.year, date.month, date.day);

      // if date already exists in dataset, increment by 1
      if (dataset.containsKey(normalizedDate)) {
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      } else {
        // else initialize it with just count of 1
        dataset[normalizedDate] = 1;
      }
    }
  }

  return dataset;
}
