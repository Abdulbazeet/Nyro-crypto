import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
