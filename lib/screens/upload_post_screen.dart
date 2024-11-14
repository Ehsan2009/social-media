import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadPostScreen extends StatelessWidget {
  const UploadPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'U P L O A D',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.upload),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // upload button
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                child: const Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(height: 30),

              // caption TextFormField
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Caption',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.trim().length < 4) {
                    return 'Please enter atleast 4 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  // enteredName = value!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
