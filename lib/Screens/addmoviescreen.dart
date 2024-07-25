import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:movies_list_app/modals/moviesmodal.dart';
import 'package:movies_list_app/providers/moviesprovider.dart';
import 'dart:io';
class AddMovieScreen extends StatefulWidget {
  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _directorController = TextEditingController();
  File? _poster;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _poster = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Movie')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Movie Name'),
                validator: (value) => value!.isEmpty ? 'Enter movie name' : null,
              ),
              TextFormField(
                controller: _directorController,
                decoration: InputDecoration(labelText: 'Director'),
                validator: (value) => value!.isEmpty ? 'Enter director name' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Choose Poster'),
              ),
              SizedBox(height: 20),
              _poster != null
                  ? Image.file(
                      _poster!,
                      height: 150,
                    )
                  : Text('No image selected'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _poster != null) {
                    final movie = Movie(
                      name: _nameController.text,
                      director: _directorController.text,
                      poster: _poster!,
                    );
                    Provider.of<MovieProvider>(context, listen: false).addMovie(movie);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Movie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
