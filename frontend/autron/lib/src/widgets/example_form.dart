import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExampleFormWidget extends StatelessWidget {
  final String softwareName;
  final VoidCallback? onBack;

  const ExampleFormWidget({
    super.key,
    required this.softwareName,
    this.onBack,
  });

  String formatImageName(String name) {
    return name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '').trim();
  }

  Future<bool> _isAssetAvailable(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedImageName = formatImageName(softwareName);
    final assetPath = 'assets/images/forms/$formattedImageName.png';

    return Scaffold(
      appBar: AppBar(
        title: Text('Example Form for $softwareName'),
        leading: onBack != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBack,
              )
            : null,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<bool>(
            future: _isAssetAvailable(assetPath),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Error loading image',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              if (snapshot.hasData && snapshot.data == true) {
                return Center(
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.contain,
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'No example form found for $softwareName',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
