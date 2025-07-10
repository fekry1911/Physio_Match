import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerWidget extends StatelessWidget {
  const LoadingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade600,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    Container(
                      height: 12,
                      width: 150,
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ],
                ),
              ),
            ],
          ).animate().slideY(duration: 500.ms, begin: index>3 ? -1.0 : 1.0, end: 0.0),
        ),
      ),
    );
  }
}
