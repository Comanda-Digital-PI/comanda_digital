import 'package:flutter/material.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});
  
  @override
  Widget build(Object context) {
    return  Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.construction,
                    color: Colors.grey.shade700,
                    size: 60,
                  ),
                   Text(
                    'Recurso em construção...',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ],
          ) 
        )
      ],
    );
  }
  
}