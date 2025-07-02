import 'package:flutter/material.dart';

class FundingListItem extends StatelessWidget {
  final String imageUrl;
  final String fundingName;
  final String brandName;
  final String description;

  const FundingListItem({
    super.key,
    required this.imageUrl,
    required this.fundingName,
    required this.brandName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 1. 왼쪽 이미지 영역
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: SizedBox(
          width: 80,
          height: 80,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
              );
            },
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                fundingName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                brandName,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      // 3. 탭(클릭) 제스처 처리
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    );
  }
}