import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/model/model_notes.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddNotes extends StatefulWidget {
  final NotesModel? model;
  const AddNotes({super.key, this.model});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  //----- CAMPOS -----
  final TextEditingController txtTitulo = TextEditingController();
  final TextEditingController txtDesc = TextEditingController();
  String editONew = "";
  //----------
  @override
  void initState() {
    super.initState();
    initialiseValues();
  }
  //----- VALORES INICIALES -----
  void initialiseValues() {
    initializeDateFormatting('es');
    if (widget.model != null) {
      editONew = "EDITAR";
      txtTitulo.text = widget.model!.titulo!;
      txtDesc.text = widget.model!.descripcion!;
    } else {
      editONew = "AGREGAR";
    }
  }
  //---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //----- BARRA SUPERIOR -----
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,          
          children: [            
            Row(
              children: [
                // *** Botón de regresar ***
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 35, width: 35,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset('assets/Images/back.png'),
                    ),),
                ),
                const SizedBox(width: 15,),
                // *** Titulo pagina ***
                Text(
                  editONew,
                  style: GoogleFonts.dmSerifText(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ],
            ),
            // *** Boton de agregar ***
            IconButton(
              onPressed: () {
                //-- Si el model es null
                if (widget.model == null) {
                  if(txtTitulo.text.isNotEmpty && txtDesc.text.isNotEmpty){
                    final map = {
                      "titulo": txtTitulo.text,
                      "descripcion": txtDesc.text,
                      "fecha": DateTime.now().toString(),
                    };
                    final notesModel = NotesModel.fromJson(map);
                    Navigator.pop(context, notesModel);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Favor de no dejar campos vacíos'),
                    ));
                  }
                //-- Si el model NO es null
                } else {
                  if (txtTitulo.text.isNotEmpty && txtDesc.text.isNotEmpty) {
                    final map = {
                    "titulo": txtTitulo.text,
                    "descripcion": txtDesc.text,
                    "fecha": widget.model!.fecha!,
                  };
                  final notesModel = NotesModel.fromJson(map);
                  Navigator.pop(context, notesModel);                    
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Favor de no dejar campos vacíos'),
                    ));
                  }                  
                }
              },
              icon: const Icon(Icons.archive, size: 35),
              color: Theme.of(context).colorScheme.inversePrimary,
            )
          ],
        ),
      ),
      //----- CUERPO -----
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // *** Fecha ***
            Text(DateFormat('EEEE, d MMMM', 'es').format(DateTime.now()).toUpperCase(),
             style: const TextStyle(fontSize: 15),),
            const SizedBox(height: 15,),
            // *** Titulo ***
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TextFormField(
                  maxLength: 20,
                  cursorColor: Theme.of(context).colorScheme.inversePrimary,
                  textCapitalization: TextCapitalization.words,
                  controller: txtTitulo,
                  style: const TextStyle(fontSize: 28),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Titulo",
                      counterText: ''),
                ),
              ),
            ),
            const SizedBox(height: 15,),            
            // *** Descripción ***
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextFormField(
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    controller: txtDesc,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Detalles",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

