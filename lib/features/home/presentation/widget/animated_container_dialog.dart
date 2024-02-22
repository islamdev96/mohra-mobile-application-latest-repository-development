import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../account/presentation/screen/login_screen.dart';

class AnimatedContainerDialog extends StatefulWidget {
  @override
  _AnimatedContainerDialogState createState() =>
      _AnimatedContainerDialogState();
}

class _AnimatedContainerDialogState extends State<AnimatedContainerDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        title: Text(
          Translation.current.login_required,
          style: TextStyle(
              fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular', fontSize: 16),
        ),
        content: Container(
          height: 0.05.sh,
          width: 0.8.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Translation.current.Please_log_in,
                  style: TextStyle(
                      fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                      fontSize: 16)),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColorLight)),
              onPressed: () {
                Nav.to(LoginScreen.routeName);
              },
              child: Text(Translation.current.login),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
