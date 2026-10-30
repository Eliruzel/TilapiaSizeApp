import 'package:flutter/material.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({
    super.key,
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });
  final int number;
  final IconData icon;
  final String title, description;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(26),
    decoration: BoxDecoration(
      color: const Color(0x0DFFFFFF),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0x3398DCCD)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 30, color: const Color(0xFF98E8D8)),
            const Spacer(),
            Text(
              '0$number',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Color(0x8098E8D8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            height: 1.65,
            color: Color(0xFFB7D3D5),
          ),
        ),
      ],
    ),
  );
}
