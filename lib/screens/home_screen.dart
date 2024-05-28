import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/note_design.dart';
import 'package:notes_app/db/database.dart';
import 'package:notes_app/model/model_notes.dart';
import 'package:notes_app/screens/add_note.dart';
import 'package:notes_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //----- CAMPOS -----
  List<NotesModel> notesItem = [];
  List<NotesModel> notesItemBuscar = [];
  TextEditingController txtBuscar = TextEditingController();
  //----------
  @override
  void initState() {
    super.initState();
    getData();
  }
  //----- OBTENER DATOS -----
  void getData() async {
    notesItem = await SqfliteDatabase.getDataFromDatabase();
    notesItem.sort((a, b) => b.fecha!.compareTo(a.fecha!));
    setState(() {});
    updateFilteredNotes();
  }
  //----- FILTRO DE BUSQUEDA -----
  void updateFilteredNotes() {
    setState(() {
      notesItemBuscar = notesItem.where((note) {
        final titulo = note.titulo!.toLowerCase();
        final descripcion = note.descripcion!.toLowerCase();
        final textBuscar = txtBuscar.text.toLowerCase();
        return titulo.contains(textBuscar) || descripcion.contains(textBuscar);
      }).toList();
    });
  }
  //----- EDITAR NOTA -----
  void editNote(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotes(
          model: notesItem[index],
        ),
      ),
    );
    if (result != null) {
      await SqfliteDatabase.updateDataInDatabase(result, result.fecha);
      notesItem[index] = result;
      setState(() {});
    }
  }
  //----- ELIMINAR NOTA -----
  void deleteNote(int index) async {
    // Dialog de confirmación
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "Eliminar",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          content: Text(
            "¿Estás seguro de que deseas eliminar esta nota?",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          actions: <Widget>[
            // NO
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            // SI
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "Eliminar",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
          ],
        );
      },
    );
    // Confirmación Eliminación
    if (confirmDelete == true) {
      await SqfliteDatabase.deleteDataFromDatabase(notesItem[index].fecha!);
      notesItem.removeAt(index);
      setState(() {});
    }
  }
  //---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //----- BARRA SUPERIOR -----
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // - Menu izquierdo
            Row(
              children: [
                SizedBox(
                  height: 35,
                  width: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      'assets/Images/nota.png',
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                // - Titulo
                Text('NOTAS',
                    style: GoogleFonts.dmSerifText(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.inversePrimary)),
              ],
            ),
            // - Cambio de tema
            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .esModoOscuro,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme()),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background, //Bg color
      // *** Boton de agregar ***
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // - Mandar a "agregar notas"
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNotes(),
            ),
          );
          // - Agregar nota
          if (result != null) {
            notesItem.add(result);
            notesItem.sort((a, b) => b.fecha!.compareTo(a.fecha!));
            await SqfliteDatabase.insertData(result);
            setState(() {});
          }
        },
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add,size: 35,),
      ),
      //----- CUERPO -----
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // *** Barra de busqueda ***
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    controller: txtBuscar,
                    onChanged: (_) => updateFilteredNotes(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                        hintText: 'Buscar nota',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                //---------- CATEGORIAS ------------
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          //---------- LISTA DE NOTAS ------------
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: txtBuscar.text.isEmpty
                  ? notesItem.length
                  : notesItemBuscar.length,
              itemBuilder: (context, index) {
                final NotesModel note = txtBuscar.text.isEmpty
                    ? notesItem[index]
                    : notesItemBuscar[index];
                // *** Lista de notas ***
                return NoteDesign(
                  titulo: note.titulo!,
                  desc: note.descripcion!,
                  fecha: note.fecha!,
                  pulsarEditar: () => editNote(index),
                  pulsarEliminar: () => deleteNote(index),
                );
              },
            ),
          ),
        ],
      ),
    );    
  }
}
