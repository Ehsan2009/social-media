import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'S E T T I N G S',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
      ),
      body: Card(
        elevation: 0,
        color: Theme.of(context).cardTheme.color,
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Text(
                'Dark Mode',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}