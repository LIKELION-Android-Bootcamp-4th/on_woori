import 'package:flutter/material.dart';

class BrandGridItem extends StatefulWidget {
  final String imageUrl;
  final String brandName;
  final VoidCallback onTap;

  const BrandGridItem({
    required this.imageUrl,
    required this.brandName,
    required this.onTap,
    super.key,
  });

  @override
  State<BrandGridItem> createState() => _BrandGridItemState();
}

class _BrandGridItemState extends State<BrandGridItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xfff0f0f0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('로고', style: TextStyle(color: Colors.grey)),
                  );
                },
              ),
            ),
          ),
          const SizedBox(),
          Flexible(
            child: Text(
              widget.brandName,
              style: const TextStyle(fontSize: 13, color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
