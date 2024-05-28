class NotesModel {
  String? titulo;
  String? descripcion;
  String? fecha;

  NotesModel(
      {this.titulo, this.descripcion, this.fecha});

  NotesModel.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['descripcion'] = this.descripcion;
    data['fecha'] = this.fecha;
    return data;
  }
}