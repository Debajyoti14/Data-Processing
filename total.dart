import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart totals.dart <inputFile.csv>');
    exit(1);
  }
  final inputFile = args.first;
  final lines = File(inputFile).readAsLinesSync();
  final totalDurationByTags = <String, double>{};
  lines.removeAt(0);
  var totalDuration = 0.0;
  for (var line in lines) {
    final values = line.split(',');
    final durationString = values[3].replaceAll('"', ' ');
    final duration = double.parse(durationString);
    final tag = values[5].replaceAll('"', ' ');
    final previousTotal = totalDurationByTags[tag];
    if (previousTotal == null) {
      totalDurationByTags[tag] = duration;
    } else {
      totalDurationByTags[tag] = previousTotal + duration;
    }
    totalDuration += duration;
  }
  for (var entry in totalDurationByTags.entries) {
    final durationFormatted = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'unallocated' : entry.key;
    print('$tag : ${durationFormatted} h');
  }
  print('total for all tags: ${totalDuration.toStringAsFixed(1)} h');
}

class string {}
