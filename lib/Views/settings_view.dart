import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/Providers/language_provider.dart';
import 'package:provider_state/Providers/theme_provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: Column(
        children: [
          // language
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  final langProvider = Provider.of<LanguageProvider>(
                    context,
                    listen: false,
                  );

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: const Text("English"),
                          onTap: () {
                            langProvider.setLocale(const Locale('en'));
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.translate),
                          title: const Text("हिंदी (Hindi)"),
                          onTap: () {
                            langProvider.setLocale(const Locale('hi'));
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.translate),
                          title: const Text("Español (Spanish)"),
                          onTap: () {
                            langProvider.setLocale(const Locale('es'));
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.translate),
                          title: const Text("Français (French)"),
                          onTap: () {
                            langProvider.setLocale(const Locale('fr'));
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.translate),
                          title: const Text("اردو (Urdu)"),
                          onTap: () {
                            langProvider.setLocale(const Locale('ur'));
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          // notification
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {},
          ),
          // privacy
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Privacy Settings"),
            onTap: () {
              // Navigate to privacy options
            },
          ),
          // logout
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              // Clear session / FirebaseAuth.signOut();
            },
          ),
          // theme
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return SwitchListTile(
                title: Text('Change Theme'),
                secondary: Icon(Icons.brightness_6),
                value: provider.isDarkTheme,
                onChanged: (val) {
                  provider.toggleTheme(val);
                },
              );
            },
          ),
          // about app
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text("About"),
              subtitle: Text("App info, version & license"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Icon(
                    Icons.flutter_dash,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  applicationName: "My Flutter App",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 Your Company",
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      "This app is built with Flutter.\n"
                      "It demonstrates modern design and state management.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
