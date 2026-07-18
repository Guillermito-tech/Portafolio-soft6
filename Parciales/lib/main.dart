import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tech Events',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        home: const InicioScreen(),
      );
}

//================ INICIO =================
class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFFA94D), Color(0xFF845EF7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double ancho = constraints.maxWidth;
                // Escala según el ancho disponible, con límites razonables
                double iconSize = (ancho * 0.25).clamp(60, 140);
                double tituloSize = (ancho * 0.08).clamp(22, 40);
                double anchoMax = ancho > 700 ? 500 : ancho * 0.9;

                return Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: anchoMax),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.rocket_launch, size: iconSize, color: Colors.white),
                          const SizedBox(height: 16),
                          Text("Tech Events",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: tituloSize, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 8),
                          const Text("Bienvenido al registro de participantes",
                              textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15)),
                          const SizedBox(height: 30),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.deepPurple),
                            icon: const Icon(Icons.how_to_reg),
                            label: const Text("Registrarme"),
                            onPressed: () => Navigator.push(
                                context, MaterialPageRoute(builder: (_) => const RegistroScreen())),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}

//================ REGISTRO =================
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});
  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();

  String? participante;
  bool errorParticipante = false;
  bool errorTec = false;
  Color colorTarjeta = Colors.teal;

  final Map<String, bool> tecnologias = {
    "Flutter": false,
    "Inteligencia Artificial": false,
    "Ciberseguridad": false,
    "Desarrollo Web": false,
    "Bases de Datos": false,
  };

  final Map<String, Color> coloresTec = {
    "Flutter": Colors.blue,
    "Inteligencia Artificial": Colors.purple,
    "Ciberseguridad": Colors.redAccent,
    "Desarrollo Web": Colors.orange,
    "Bases de Datos": Colors.green,
  };

  void mostrarError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("⚠️ Error"),
        content: Text(msg),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Aceptar"))],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  void guardar() {
    final formOk = _formKey.currentState!.validate();
    final tecSeleccionadas = tecnologias.entries.where((e) => e.value).map((e) => e.key).toList();

    setState(() {
      errorParticipante = participante == null;
      errorTec = tecSeleccionadas.isEmpty;
    });

    if (!formOk || errorParticipante || errorTec) {
      mostrarError("Complete todos los campos obligatorios.");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumenScreen(
          nombre: nombreCtrl.text,
          correo: correoCtrl.text,
          telefono: telefonoCtrl.text,
          participante: participante!,
          tecnologias: tecSeleccionadas,
          coloresTec: coloresTec,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro"), backgroundColor: Colors.deepPurple),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double ancho = constraints.maxWidth;
          bool mostrarPanel = ancho > 600; // Tablet o escritorio
          bool esEscritorio = ancho > 1000;

          Widget formulario = Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Registro de Participante",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: nombreCtrl,
                      decoration: const InputDecoration(labelText: "Nombre Completo", prefixIcon: Icon(Icons.person, color: Colors.deepPurple)),
                      validator: (v) => (v == null || v.trim().isEmpty) ? "El nombre es obligatorio" : null,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: correoCtrl,
                      decoration: const InputDecoration(labelText: "Correo Electrónico", prefixIcon: Icon(Icons.email, color: Colors.orange)),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return "El correo es obligatorio";
                        if (!RegExp(r'^[\w.\-]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(v.trim())) return "Correo inválido";
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: telefonoCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Teléfono",
                        prefixIcon: Icon(Icons.phone, color: Colors.green),
                        counterText: "",
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return "El teléfono es obligatorio";
                        if (!RegExp(r'^[0-9]{8}$').hasMatch(v.trim())) return "Debe tener exactamente 8 dígitos";
                        return null;
                      },
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 20),
                    const Text("Tipo de Participante", style: TextStyle(fontWeight: FontWeight.bold)),
                    ...["Estudiante", "Profesional", "Docente"].map((op) => RadioListTile<String>(
                          title: Text(op),
                          value: op,
                          groupValue: participante,
                          activeColor: Colors.deepPurple,
                          onChanged: (v) => setState(() {
                            participante = v;
                            errorParticipante = false;
                          }),
                        )),
                    if (errorParticipante)
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text("Seleccione un tipo de participante", style: TextStyle(color: Colors.red, fontSize: 12)),
                      ),

                    const SizedBox(height: 10),
                    const Text("Tecnologías de Interés", style: TextStyle(fontWeight: FontWeight.bold)),
                    ...tecnologias.keys.map((t) => CheckboxListTile(
                          title: Text(t),
                          value: tecnologias[t],
                          activeColor: coloresTec[t],
                          onChanged: (v) => setState(() {
                            tecnologias[t] = v!;
                            errorTec = false;
                          }),
                        )),
                    if (errorTec)
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text("Seleccione al menos una tecnología", style: TextStyle(color: Colors.red, fontSize: 12)),
                      ),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Tarjeta tocada"))),
                      onDoubleTap: () => setState(() {
                        colorTarjeta = colorTarjeta == Colors.teal ? Colors.pink : Colors.teal;
                      }),
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Información"),
                          content: const Text("Mantuviste presionada la tarjeta"),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Aceptar"))],
                        ),
                      ),
                      child: Card(
                        color: colorTarjeta,
                        elevation: 8,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Tarjeta Interactiva\n(toca, doble toque o mantén presionado)",
                              style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                        icon: const Icon(Icons.save),
                        label: const Text("Guardar Registro"),
                        onPressed: guardar,
                      ),
                    ),
                  ],
                ),
            ),
          );

          if (!mostrarPanel) {
            // Móvil: una sola columna, solo el formulario
            return formulario;
          }

          // Tablet/Escritorio: formulario a la izquierda, imagen + resumen en vivo a la derecha
          final tecActuales = tecnologias.entries.where((e) => e.value).map((e) => e.key).toList();

          Widget panelDerecho = Container(
            color: Colors.deepPurple.shade50,
            padding: EdgeInsets.all(esEscritorio ? 32 : 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(Icons.groups, size: esEscritorio ? 130 : 90, color: Colors.deepPurple),
                  const SizedBox(height: 10),
                  Text("Tech Events",
                      style: TextStyle(
                          fontSize: esEscritorio ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Resumen en vivo",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple)),
                          const Divider(),
                          Text("👤 ${nombreCtrl.text.isEmpty ? '-' : nombreCtrl.text}"),
                          const SizedBox(height: 6),
                          Text("📧 ${correoCtrl.text.isEmpty ? '-' : correoCtrl.text}"),
                          const SizedBox(height: 6),
                          Text("📱 ${telefonoCtrl.text.isEmpty ? '-' : telefonoCtrl.text}"),
                          const SizedBox(height: 6),
                          Text("🎓 ${participante ?? '-'}"),
                          const SizedBox(height: 10),
                          if (tecActuales.isEmpty)
                            const Text("Sin tecnologías seleccionadas",
                                style: TextStyle(color: Colors.grey, fontSize: 13))
                          else
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: tecActuales
                                  .map((t) => Chip(
                                        label: Text(t, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                        backgroundColor: coloresTec[t],
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ))
                                  .toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

          return Row(
            children: [
              Expanded(flex: esEscritorio ? 3 : 1, child: formulario),
              Expanded(flex: esEscritorio ? 2 : 1, child: panelDerecho),
            ],
          );
        },
      ),
    );
  }
}

//================ RESUMEN =================
class ResumenScreen extends StatelessWidget {
  final String nombre, correo, telefono, participante;
  final List<String> tecnologias;
  final Map<String, Color> coloresTec;

  const ResumenScreen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.participante,
    required this.tecnologias,
    required this.coloresTec,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Resumen"), backgroundColor: Colors.teal),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double ancho = constraints.maxWidth;

            // Ancho máximo del contenido según el tamaño de pantalla
            double anchoMax = ancho > 900
                ? 650
                : ancho > 600
                    ? 500
                    : double.infinity;

            // Padding y tamaños de texto que escalan con la pantalla
            double padding = ancho > 600 ? 28 : 16;
            double tituloSize = (ancho * 0.05).clamp(18, 22);
            double textoSize = (ancho * 0.035).clamp(14, 16);

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: anchoMax),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.deepPurple.shade50,
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Datos Personales",
                                  style: TextStyle(fontSize: tituloSize, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text("👤 Nombre: $nombre", style: TextStyle(fontSize: textoSize)),
                              Text("📧 Correo: $correo", style: TextStyle(fontSize: textoSize)),
                              Text("📱 Teléfono: $telefono", style: TextStyle(fontSize: textoSize)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Chip(
                        label: Text(participante, style: const TextStyle(color: Colors.white)),
                        backgroundColor: Colors.deepOrange,
                        avatar: const Icon(Icons.badge, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text("Tecnologías Seleccionadas:",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: textoSize)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: tecnologias
                            .map((t) => Chip(
                                  label: Text(t, style: const TextStyle(color: Colors.white)),
                                  backgroundColor: coloresTec[t] ?? Colors.grey,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                          icon: const Icon(Icons.home),
                          label: const Text("Volver al Inicio"),
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (_) => const InicioScreen()), (r) => false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}