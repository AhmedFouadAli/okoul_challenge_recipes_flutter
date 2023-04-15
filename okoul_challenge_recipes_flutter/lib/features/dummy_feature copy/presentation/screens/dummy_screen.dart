import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DummyScreen extends ConsumerWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Screen'),
      ),
      body: const Center(
        child: Text('Dummy Screen'),
      ),
    );
  }
}
