import 'package:gamers_notes/data/state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, w) {
        if (!state.loaded) return const Center(child: Text("Lädt..."),);
        return Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: const [
                  Text("Option 1")
                ],
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              state.notes.length, //max(state.notes.length * 2 - 1, 0),
              (index) {
                //if (index % 2 == 1) return const Flexible(child: Divider());
                final note = state.notes.values.toList()[index];// ~/ 2];
                return Flexible(
                  child: Card(
                    child: GestureDetector(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          color: Colors.amber,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(note.id),
                              Text(note.name)
                            ],
                          ),
                        ),
                      ),
                      onTap: () => context.push("/note/${note.id}"),
                    ),
                  ),
                );
              }
            ),
          ),
        );
      }
    );
  }

  @override
  void initState() {
    Provider.of<AppState>(context, listen: false).load(notify: false);
    super.initState();
  }
}