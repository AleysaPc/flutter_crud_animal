import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../animal.dart';

class AddEditAnimalScreen extends StatefulWidget {
  final Animal? animal;

  AddEditAnimalScreen({this.animal});

  @override
  _AddEditAnimalScreenState createState() => _AddEditAnimalScreenState();
}

class _AddEditAnimalScreenState extends State<AddEditAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _especieController = TextEditingController();
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.animal != null) {
      _nombreController.text = widget.animal!.nombre;
      _especieController.text = widget.animal!.especie;
    }
  }

  void saveAnimal() async {
    if (_formKey.currentState!.validate()) {
      final animal = Animal(
        id: widget.animal?.id,
        nombre: _nombreController.text,
        especie: _especieController.text,
      );

      if (widget.animal == null) {
        await dbHelper.insertAnimal(animal);
      } else {
        await dbHelper.updateAnimal(animal);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 93, 128),
          title: Text(
            widget.animal == null ? 'Agregar Animal' : 'Editar Animal',
          ),
          foregroundColor: Colors.white),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Este campo es requerido' : null,
              ),
              TextFormField(
                controller: _especieController,
                decoration: InputDecoration(labelText: 'Especie'),
                validator: (value) =>
                    value!.isEmpty ? 'Este campo es requerido' : null,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: saveAnimal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
