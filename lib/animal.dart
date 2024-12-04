class Animal {
  int? id;
  String nombre;
  String especie;

  Animal({this.id, required this.nombre, required this.especie});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'especie': especie,
    };
  }

  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      id: map['id'],
      nombre: map['nombre'],
      especie: map['especie'],
    );
  }
}
