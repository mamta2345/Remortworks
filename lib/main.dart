import 'package:flutter/material.dart';
import 'package:flutter_application_2/Provideer/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const UiDesign());
}

class UiDesign extends StatelessWidget {
  const UiDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhoneProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PhoneScreen(),
      ),
    );
  }
}

class PhoneScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhoneProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Info Finder",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Enter Phone ID",
                  hintText: "Example: 1",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    provider.getPhoneById(_controller.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Fetch Phone Info",
                    style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            provider.isLoading
                ? const CircularProgressIndicator()
                : provider.phoneData != null
                    ? Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.phoneData!['name'] ?? "No Name",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "ID: ${provider.phoneData!['id'] ?? 'N/A'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              if (provider.phoneData!['data'] != null) ...[
                                const SizedBox(height: 10),
                                Divider(color: Colors.grey[400]),
                                const SizedBox(height: 10),
                                for (var entry
                                    in provider.phoneData!['data'].entries)
                                  Text(
                                    "${entry.key}: ${entry.value}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : const Text("No data available",
                        style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
