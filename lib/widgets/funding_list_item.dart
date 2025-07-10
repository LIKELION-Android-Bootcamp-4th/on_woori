import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FundingListItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String fundingName;
  final String brandName;
  final String description;
  final String linkUrl;

  const FundingListItem({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.fundingName,
    required this.brandName,
    required this.description,
    required this.linkUrl,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw '해당 URL 에 접근할 수 없습니다. $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                child: const Icon(Icons.image_not_supported_outlined,
                    color: Colors.grey),
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
                Expanded(
                  child: Text(
                    fundingName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
              ]),
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
      onTap: () {
        if (linkUrl.isNotEmpty) {
          _launchURL(linkUrl);
        }
      },
    );
  }
}