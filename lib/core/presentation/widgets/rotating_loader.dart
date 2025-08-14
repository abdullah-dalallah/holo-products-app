import 'package:flutter/material.dart';

class RotatingLoader extends StatefulWidget {
  final Color color;
  const RotatingLoader({this.color=Colors.black,super.key});

  @override
  _RotatingLoaderState createState() => _RotatingLoaderState();
}

class _RotatingLoaderState extends State<RotatingLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _controller,
        child:  ImageIcon(const AssetImage('assets/images/icons/Star.png'),size: 50,color: widget.color,),
      ),
    );
  }
}