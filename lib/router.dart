import 'package:go_router/go_router.dart';

import 'pages/home.dart';
import 'pages/note.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/note/:id",
      builder: (context, state) => NoteScreen(noteID: state.params["id"]!),
    ),
    // GoRoute(
    //   path: "/folder/:id"
    // )
  ]
);
