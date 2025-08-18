import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/Providers/Data/fetch_provider.dart';
import 'package:provider_state/Providers/theme_provider.dart';
import 'package:provider_state/Views/settings_view.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});
  @override
  State<UserListView> createState() => _UserListViewState();
}

bool IsSwitchOn = false;

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FetchProvider>(context, listen: false).getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                // Handle the menu action
                if (value == 'setting') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsView()),
                  );
                } else if (value == 'delete') {
                  print("Delete clicked");
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'setting', child: Text('Settings')),
                const PopupMenuItem(value: 'delete', child: Text('Select All')),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<FetchProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.users.isEmpty) {
                    return const Center(child: Text("No users found"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.users.length,
                    itemBuilder: (context, index) {
                      final user = provider.users[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(121, 158, 158, 158),
                          ),
                          child: (user.name != null)
                              ? Center(
                                  child: Text(
                                    user.username![0].toUpperCase(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              : Icon(Icons.person),
                        ),
                        title: Text(
                          user.username ?? "Unnamed",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          user.email ?? "No Email",
                          style: TextStyle(fontSize: 16),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit, size: 24),
                            SizedBox(width: 10),
                            Icon(Icons.delete, size: 24),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
