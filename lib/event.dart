import 'package:audioplayers/audioplayers.dart';

class Event {
  final String title;
  final String description;
  final DateTime date;
  final String? imageUrl;
  final String? audioUrl;

  Event({
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
    this.audioUrl,
  });
}
