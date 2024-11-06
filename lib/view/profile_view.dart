import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsproductsapp/constants/app_typography.dart';
import 'package:shopsproductsapp/utils/responsive.dart';
import 'package:shopsproductsapp/view/login_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('userEmail') ?? 'No email found';
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context: context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: AppTypography.outfitBold),
      ),
      body: Padding(
        padding: EdgeInsets.all(responsive.wp(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/icons/profile.png'),
            ),
            SizedBox(height: responsive.hp(5)),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(responsive.wp(4)),
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.blue),
                  title: Text(_userEmail,
                      style: AppTypography.outfitMedium
                          .copyWith(fontSize: responsive.sp(16))),
                  onTap: () {
                  },
                ),
              ),
            ),
            SizedBox(height: responsive.hp(5)),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: Text('Settings',
                    style: AppTypography.outfitMedium
                        .copyWith(fontSize: responsive.sp(16))),
                onTap: () {
                },
              ),
            ),
            SizedBox(height: responsive.hp(5)),

            ElevatedButton(
              onPressed: _logout,
              child: Text('Logout',
                  style: AppTypography.outfitBold
                      .copyWith(fontSize: responsive.sp(14))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(responsive.wp(60),
                    responsive.hp(5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
