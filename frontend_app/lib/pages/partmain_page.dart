import 'package:flutter/material.dart';
import 'package:frontend_app/pages/welcome_page.dart';
import 'package:frontend_app/participant_study_tabs/dataview_part.dart';
import 'package:frontend_app/participant_study_tabs/selfreport_part.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ParticipantMain extends StatefulWidget {
  const ParticipantMain({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParticipantMainState createState() => _ParticipantMainState();
}

class _ParticipantMainState extends State<ParticipantMain> {
  int _selectedIndex = 1;
  final String _userName = "X";  // Use user's name from API

  List<Widget> tabContents = [
    const Center(child: Text('Mail content here', style: TextStyle(fontSize: 20))),
    StudiesContent(),  // This will be a custom widget for the "My Study" tab.
    AccountContent(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
            child: Center(
              child: Text(
                'Welcome $_userName',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTap,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              color: Colors.black,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.grey[300]!,
              gap: 10,
              tabs: const [
                GButton(
                  icon: Icons.mail,
                  text: 'Mail',
                ),
                GButton(
                  icon: Icons.folder,
                  text: 'My Study',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Account',
                ),
              ],
              tabMargin: const EdgeInsets.all(4),
              tabBorderRadius: 8,
              tabActiveBorder: Border.all(color: Colors.black, width: 2),
              tabBorder: Border.all(color: Colors.grey, width: 2),
            ),
          ),
          Expanded(
            child: tabContents[_selectedIndex], 
          ),
        ],
      ),
    );
  }
}

class StudiesContent extends StatelessWidget {
  const StudiesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              title: const Text("Study View", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Not implemented for now
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              title: const Text("Tasks", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Not implemented for now
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: const Border(top: BorderSide(color: Colors.grey), bottom: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              title: const Text("View Data", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DataView()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AccountContent extends StatelessWidget {
  const AccountContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              title: const Text("Self Report", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelfReport()));
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              title: const Text("Help", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Not implemented for now
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: const Border(top: BorderSide(color: Colors.grey), bottom: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              title: const Text("Sign Out", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}