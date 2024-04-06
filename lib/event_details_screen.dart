import 'package:flutter/material.dart';
import 'package:pld_app/event.dart';
import 'package:audioplayers/audioplayers.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  EventDetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Evento'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              event.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Fecha: ${event.date}',
              style: TextStyle(fontSize: 16),
            ),
            if (event.imageUrl != null) ...[
              SizedBox(height: 16),
              Image.network(event.imageUrl!),
            ],
            if (event.audioUrl != null) ...[
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  AudioPlayer player = AudioPlayer();
                  player.play(event.audioUrl! as Source);
                },
                child: Text('Reproducir Audio'),
              ),
            ],
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
