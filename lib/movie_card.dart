import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String releaseDate;
  final String posterUrl;
  final String overview;
  final num voteAverage;

  MovieCard(
      {Key? key,
      required this.title,
      required this.releaseDate,
      required this.posterUrl,
      required this.overview,
      required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double userRating = voteAverage.toDouble() / 2;
    // IconData? selectedIcon;

    return AspectRatio(
      aspectRatio: 2.5, // 寬高比為 5:2
      child: Padding(
        padding: const EdgeInsets.all(12.0), // 調整padding大小
        child: Card(
          elevation: 5, // 設置卡片的陰影大小
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // 調整卡片邊緣的弧度
          ),
          child: InkWell(
            onTap: () {
              // 點擊卡片後的處理
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  // 調整圖片的邊角弧度
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/original$posterUrl",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      overview.isNotEmpty ? hasDescCard() : noDescCard()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hasDescCard() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            releaseDate,
            style: const TextStyle(fontSize: 16),
          ),
          Expanded(
            child: Center(
              child: Text(
                overview,
                style: const TextStyle(fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget noDescCard() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            releaseDate,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
