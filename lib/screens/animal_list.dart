import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../animal.dart';
import 'add_edit_animal.dart';

class AnimalListScreen extends StatefulWidget {
  @override
  _AnimalListScreenState createState() => _AnimalListScreenState();
}

class _AnimalListScreenState extends State<AnimalListScreen> {
  final dbHelper = DatabaseHelper();

  List<Animal> animals = [];

  @override
  void initState() {
    super.initState();
    fetchAnimals();
  }

  Future<void> fetchAnimals() async {
    final data = await dbHelper.getAnimals();
    setState(() {
      animals = data;
    });
  }

  void deleteAnimal(int id) async {
    await dbHelper.deleteAnimal(id);
    fetchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 93, 128),
        title: Text(
          'Lista de Animales',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          final animal = animals[index];
          return ListTile(
            title: Text(animal.nombre),
            subtitle: Text(animal.especie),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddEditAnimalScreen(animal: animal),
                      ),
                    );
                    fetchAnimals();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteAnimal(animal.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditAnimalScreen(),
            ),
          );
          fetchAnimals();
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}
