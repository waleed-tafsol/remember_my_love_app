import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/constants.dart';

class GradientButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final Color? cornorIconColor;
  final Color? cornorIconBackgroundColor;
  final List<Color> gradients;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.gradients,
    this.textColor,
    this.cornorIconColor,
    this.cornorIconBackgroundColor,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              // Calculate the colors for the gradient based on animation value
              Color startColor = widget.gradients[0];
              Color endColor = widget.gradients[1];
              Color animatedColor =
                  Color.lerp(startColor, endColor, _animation.value)!;

              return Container(
                height: kButtonHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [animatedColor, endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Center(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor ?? Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: kButtonHeight / 2,
              backgroundColor:
                  widget.cornorIconBackgroundColor ?? Colors.blue[900],
              child: Icon(Icons.arrow_outward_outlined,
                  color: widget.cornorIconColor ??
                      Theme.of(context).iconTheme.color),
            ),
          ),
        ],
      ),
    );
  }
}
