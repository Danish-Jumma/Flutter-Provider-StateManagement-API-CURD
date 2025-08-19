import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/Providers/Data/fetch_provider.dart';
import 'package:provider_state/Providers/theme_provider.dart';
import 'package:provider_state/Views/settings_view.dart';
import 'package:shimmer/shimmer.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});
  @override
  State<UserListView> createState() => _UserListViewState();
}

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
                    // show shimemer effect while loading
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            // leading → avatar container
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),

                            // title → container styled text
                            title: Container(
                              height: 18, // fixed height for shimmer look
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),

                            // subtitle → container styled text
                            subtitle: Container(
                              margin: const EdgeInsets.only(top: 6),
                              height: 14,
                              width: 150, // smaller width for shimmer feel
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),

                            // trailing → fixed size container
                            trailing: SizedBox(
                              width: 36,
                              height: 36,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surface.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
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
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                        255,
                                        76,
                                        168,
                                        79,
                                      ),
                                    ),
                                  ),
                                )
                              : Icon(Icons.person),
                        ),
                        title: Text(
                          user.name ?? "Unnamed",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          user.email ?? "No Email",
                          style: TextStyle(fontSize: 16),
                        ),

                        // trailing
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.call,
                            color: const Color.fromARGB(255, 76, 168, 79),
                            size: 30,
                          ),
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
