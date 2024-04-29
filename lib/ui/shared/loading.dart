import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.child,
    this.isLoading = false,
    this.overlayOpacity = 0.6,
    super.key,
  });
  final Widget child;
  final bool isLoading;
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    final Size window = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        child,
        isLoading
            ? Container(
                width: window.width,
                height: window.height,
                alignment: Alignment.center,
                color: Colors.black.withOpacity(overlayOpacity),
                child: const CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.grey,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
