import 'package:flutter/material.dart';

class BitacoraScreen extends StatelessWidget {
  const BitacoraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> bitacora = [
      {
        "titulo": "Presentación del curso",
        "descripcion":
            "Se explicó la metodología de trabajo, el sistema de evaluación y los objetivos principales de la asignatura."
      },
      {
        "titulo": "Introducción a Flutter",
        "descripcion":
            "Se conocieron las herramientas y ventajas de Flutter para desarrollar aplicaciones móviles multiplataforma."
      },
      {
        "titulo": "Configuración del entorno",
        "descripcion":
            "Se instalaron las dependencias necesarias para programar con Flutter y ejecutar proyectos."
      },
      {
        "titulo": "Widget Container",
        "descripcion":
            "Se practicó la creación de interfaces utilizando colores, tamaños y márgenes."
      },
      {
        "titulo": "Página de destinos",
        "descripcion":
            "Se desarrolló una pantalla con imágenes y tarjetas para mostrar distintos lugares."
      },
      {
        "titulo": "Investigación sobre eventos",
        "descripcion":
            "Se estudió la forma en que los usuarios interactúan con botones y otros componentes."
      },
      {
        "titulo": "Diseño responsivo",
        "descripcion":
            "Se aplicaron técnicas para adaptar la aplicación a diferentes tamaños de pantalla."
      },
      {
        "titulo": "Consumo de APIs",
        "descripcion":
            "Se realizaron peticiones HTTP y se procesaron datos en formato JSON."
      },
      {
        "titulo": "SQLite",
        "descripcion":
            "Se investigó cómo almacenar información localmente dentro de una aplicación."
      },
      {
        "titulo": "Proyecto final",
        "descripcion":
            "Se inició el desarrollo del proyecto semestral integrando los conocimientos adquiridos."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bitácora de aprendizaje"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bitacora.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text(
                bitacora[index]["titulo"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  bitacora[index]["descripcion"]!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}