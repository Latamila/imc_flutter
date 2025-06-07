import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  String resultado = '';

  void calcularIMC() {
    final pesoText = pesoController.text.trim();
    final alturaText = alturaController.text.trim();

    final peso = double.tryParse(pesoText);
    final altura = double.tryParse(alturaText);

    if (peso == null || altura == null || altura <= 0) {
      setState(() {
        resultado = '❗ Preencha os campos corretamente!';
      });
      return;
    }

    final imc = peso / (altura * altura);
    String classificacao;

    if (imc < 18.5) {
      classificacao = 'Abaixo do peso';
    } else if (imc < 25) {
      classificacao = 'Peso normal';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else {
      classificacao = 'Obesidade';
    }

    setState(() {
      resultado = '✅ IMC: ${imc.toStringAsFixed(2)} - $classificacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 20),
            Text(
              resultado,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
