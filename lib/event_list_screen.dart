import 'package:flutter/material.dart';
import 'package:pld_app/event.dart';
import 'package:pld_app/event_details_screen.dart';
import 'package:pld_app/event_registration_screen.dart';
import 'package:pld_app/event_edit_screen.dart';
import 'package:pld_app/acerca_de_screen.dart'; // Importa la pantalla AcercaDeScreen

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos del PLD'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcercaDeScreen()), // Redirige a la pantalla AcercaDeScreen
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.dangerous),
            onPressed: () {
              _showDeleteAllConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: events.isEmpty
          ? Center(
              child: Text(
                '¡Comienza a registrar eventos!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.red[50],
                  child: ListTile(
                    title: Text(
                      events[index].title,
                      style: TextStyle(color: Colors.black87),
                    ),
                    subtitle: Text(
                      events[index].description,
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.purple,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventEditScreen(event: events[index]),
                              ),
                            ).then((editedEvent) {
                              if (editedEvent != null) {
                                setState(() {
                                  events[index] = editedEvent;
                                });
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.purple,
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, index);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventDetailsScreen(event: events[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventRegistrationScreen()),
          ).then((newEvent) {
            if (newEvent != null) {
              setState(() {
                events.add(newEvent);
              });
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar eliminación'),
        content: Text('¿Está seguro de que desea eliminar este evento?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                events.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAllConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¡ALERTA!'),
        content: Text('¿Está seguro de que desea eliminar todos los eventos del partido?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                events.clear();
              });
              Navigator.of(context).pop();
            },
            child: Text('Eliminar todos'),
          ),
        ],
      ),
    );
  }
}
