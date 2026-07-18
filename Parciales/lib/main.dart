import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belleza Natural',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/pantalla2': (context) => const Pantalla2(),
        '/perfil': (context) => const PerfilPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text(
          "Belleza Natural",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/imagenes/atardecer1.jpeg",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpcXd9UghsiHeT42KiCFjLF4qXB4QgEjCsXw&s",
                        width: 150,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text("Paraiso 1"),
                  ],
                ),

                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoQrkHPNpKhIQ4Z1a8QfUeo7MpEbHpt7M3Eg&s",
                        width: 150,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text("Paraiso 2"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Explora la naturaleza y su magia",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.videocam, size: 30),
                SizedBox(width: 20),
                Icon(Icons.mic, size: 30),
                SizedBox(width: 20),
                Icon(Icons.call_end, size: 30, color: Colors.red),
              ],
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pantalla2');
        },
        child: const Icon(Icons.arrow_forward),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Tooltip(message: "Inicio", child: Icon(Icons.home)),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Tooltip(message: "Favoritos", child: Icon(Icons.favorite)),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: Tooltip(message: "Perfil", child: Icon(Icons.person)),
            label: "Perfil",
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/perfil');
          }
        },
      ),
    );
  }
}

class Pantalla2 extends StatefulWidget {
  const Pantalla2({super.key});

  @override
  State<Pantalla2> createState() => _Pantalla2State();
}

class _Pantalla2State extends State<Pantalla2> {

  String imagenActual = "";

  @override
  void initState() {
    super.initState();
    cambiarImagen();
  }

  void cambiarImagen() {
    final random = Random();

    List<String> imagenes = [
      "assets/imagenes/atardecer2.jpeg",
      "assets/imagenes/atardecer3.jpeg",
      "assets/imagenes/atardecer4.jpeg",
      "assets/imagenes/atardecer5.jpeg",
    ];

    imagenActual = imagenes[random.nextInt(imagenes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla 2"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagenActual,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "DISTINTAS VISTAS EXPLORADAS",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Tooltip(message: "Inicio", child: Icon(Icons.home)),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Tooltip(message: "Perfil", child: Icon(Icons.person)),
            label: "Perfil",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          } else if (index == 1) {
            Navigator.pushNamed(context, '/perfil');
          }
        },
      ),
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/imagenes/perfil.jpeg"),
            ),

            const SizedBox(height: 15),

            const Text(
              "Guillermo Cuevas",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "Explorador",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            const Text(
              "Lugares Visitados",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.place),
                    title: Text("Montaña Majestuosa"),
                  ),
                  ListTile(
                    leading: Icon(Icons.place),
                    title: Text("Río Sereno"),
                  ),
                  ListTile(
                    leading: Icon(Icons.place),
                    title: Text("Playa Paraíso"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}