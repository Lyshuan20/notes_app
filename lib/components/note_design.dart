import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/components/config_notas.dart';
import 'package:popover/popover.dart';

class NoteDesign extends StatelessWidget {
  final String titulo;
  final String desc;
  final String fecha;  
  final void Function()? pulsarEditar;
  final void Function()? pulsarEliminar;

  const NoteDesign(
      {super.key,
      required this.titulo,
      required this.desc,
      required this.fecha,
      required this.pulsarEditar,
      required this.pulsarEliminar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      // *** List Title ***
      child: GestureDetector(
        // - Editar al tocas
        onTap: pulsarEditar,
        child: ListTile(
          // *** Texto de la nota ***
          title: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // - Titulo nota
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // - Descripcion nota
                  Text(
                    desc.length <= 35 ? desc : '${desc.substring(0, 35)}...',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 3),
                  // - Fecha nota
                  Text(
                    DateFormat('dd/MM/yy').format(DateTime.parse(fecha)),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                  )
                ],
              ),
            ),
          ), //---
          // *** Editar, eliminar nota ***
          trailing: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showPopover(
                  width: 100,
                  height: 100,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  context: context,
                  bodyBuilder: (context) => NotasConfig(
                    onEditTap: pulsarEditar, onDeleteTap: pulsarEliminar,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
