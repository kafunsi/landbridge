import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/route_names.dart';
import '../../authentication/application/auth_controller.dart';
import '../../../shared_widgets/app_button.dart';

class CitizenProfileScreen extends ConsumerWidget {
  const CitizenProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final user = authState.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Wasifu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text(
              user?.displayName ?? 'Jina halipo', 
              style: Theme.of(context).textTheme.headlineSmall
            ),
            Text(user?.email ?? 'Barua pepe haipo'),
            const SizedBox(height: 32),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Namba ya Simu'),
              subtitle: Text(user?.phone ?? 'Haipo'),
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Aina ya Mtumiaji'),
              subtitle: Text(user?.role.toUpperCase() ?? 'CITIZEN'),
            ),
            const Spacer(),
            AppButton(
              label: 'Toka (Logout)',
              outlined: true,
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).signOut();
                if (context.mounted) {
                  context.go(RouteNames.login);
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}