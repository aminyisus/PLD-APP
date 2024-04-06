import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'event.dart';

class EventRegistrationScreen extends StatefulWidget {
  @override
  _EventRegistrationScreenState createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? imageUrl;
  String? audioUrl;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Evento'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Fecha: ${selectedDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Seleccionar Fecha',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () async {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    setState(() {
                      imageUrl = pickedFile?.path;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.audiotrack),
                  onPressed: () async {
                    final pickedFile =
                        await FilePicker.platform.pickFiles(type: FileType.audio);
                    // Verificar si se seleccionó un archivo de audio
                    if (pickedFile != null && pickedFile.files.isNotEmpty) {
                      // Obtener los bytes del archivo de audio
                      final List<int> audioBytes = pickedFile.files.first.bytes!;
                      // Crear un objeto de tipo Uint8List para los bytes del archivo
                      final Uint8List audioUint8List = Uint8List.fromList(audioBytes);
                      // Convertir los bytes a base64
                      final String base64Audio = base64Encode(audioBytes);
                      // Asignar la URL del audio
                      setState(() {
                        audioUrl = base64Audio;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final newEvent = Event(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: selectedDate,
                  imageUrl: imageUrl,
                  audioUrl: audioUrl,
                );
                Navigator.pop(context, newEvent);
              },
              child: Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
