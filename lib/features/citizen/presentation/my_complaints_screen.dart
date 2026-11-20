import 'package:flutter/material.dart';

class MyComplaintsScreen extends StatelessWidget {
  const MyComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Malalamiko Yangu')),
      body: const Center(child: Text('Malalamiko yako yataonekana hapa (Phase 3)')),
    );
  }
}