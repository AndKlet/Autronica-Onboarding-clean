import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SoftwareBox extends StatelessWidget {
  final String name;
  final String? imageURL;
  final VoidCallback onPressed;

  const SoftwareBox({
    super.key,
    required this.name,
    this.imageURL,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        width: 160, // Width for box
        height: 120, // Height for box
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imageURL != null && imageURL!.isNotEmpty
                ? Image.network(
                    image!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset(
                        'assets/images/logo-placeholder.svg', // Fallback to placeholder image
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : SvgPicture.asset(
                    'assets/images/logo-placeholder.svg', // Default placeholder
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
