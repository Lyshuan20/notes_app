import 'package:flutter/material.dart';

class NotasConfig extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const NotasConfig({super.key, required this.onDeleteTap, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // *** Editar nota ***
        GestureDetector(
          onTap: onEditTap,
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: const Center(child: Text('Editar',
            style: TextStyle(fontWeight: FontWeight.bold),)),
          ),
        ),
        // *** Eliminar nota ***
        GestureDetector(
          onTap: onDeleteTap,
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: const Center(child: Text('Eliminar',
            style: TextStyle(fontWeight: FontWeight.bold),)),
          ),
        )
      ],
      
    );
  }
}