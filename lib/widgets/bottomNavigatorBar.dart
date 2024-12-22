import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitmap2/constant/custom_colors.dart';
import 'package:fitmap2/screens/homepage/userHomepage.dart';
import 'package:fitmap2/screens/test/coach.dart';
import 'package:fitmap2/screens/test/user.dart';
import 'package:fitmap2/utils/authConstant.dart';
import 'package:flutter/material.dart';

class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({super.key});

  @override
  _BottomNavigatorBarState createState() => _BottomNavigatorBarState();
}

void _signOut(BuildContext context) async {
  try {
    await client.auth.signOut(); // Sign out the user
    if (client.auth.currentSession == null) {
      Navigator.pushReplacementNamed(context, '/'); // Redirect to login/signup
    } else {
      context.showErrorMessege('Failed to log out properly.');
    }
  } catch (e) {
    context.showErrorMessege('Error signing out: ${e.toString()}');
  }
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int _currentIndex = 0;

  final GlobalKey<NavigatorState> _Home = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _Progress = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _Plan = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.mainBG,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _Home,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const Userhomepage(),
            ),
          ),
          Navigator(
            key: _Progress,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const Coach(),
            ),
          ),
          Navigator(
            key: _Plan,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const User(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: CustomColors.mainColor,
        index: _currentIndex,
        onTap: (val) {
          if (val == 3) {
            // Assuming the sign-out button is at index 3
            _signOut(context);
          } else {
            _onTap(val, context);
          }
        },
        backgroundColor: Colors.transparent,
        items: [
          Icon(
            Icons.home,
            size: 28,
            color: _currentIndex == 0 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.show_chart, // Replace with a suitable icon for "progress"
            size: 36,
            color: _currentIndex == 1 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.list, // Replace with a suitable icon for "bulleted list"
            size: 28,
            color: _currentIndex == 2 ? Colors.black : Colors.white,
          ),
          const Icon(Icons.logout, size: 28, color: Colors.white),
        ],
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          _Home.currentState?.popUntil((route) => route.isFirst);
          break;
        case 1:
          _Progress.currentState?.popUntil((route) => route.isFirst);
          break;
        case 2:
          _Plan.currentState?.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }
}
