import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Activity extends ConsumerStatefulWidget {
  const Activity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActivityState();
}

class _ActivityState extends ConsumerState<Activity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}