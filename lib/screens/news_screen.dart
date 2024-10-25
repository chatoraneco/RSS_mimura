// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; 
// import 'package:ogp_data_extract/ogp_data_extract.dart';
// import 'package:webfeed_plus/domain/rss_feed.dart';
// import 'package:webfeed_plus/domain/rss_item.dart';
// import 'webview_screen.dart';

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   List<RssItem> _newsItems = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchNews();
//   }

//   Future<void> _fetchNews() async {
//     setState(() {
//       _isLoading = true;
//     });

//     const rssUrl =
//         'https://api.allorigins.win/get?url=https://news.yahoo.co.jp/rss/media/gifuweb/all.xml';

//     try {
//       final response = await http.get(Uri.parse(rssUrl));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final content = json['contents'] as String;

//         final decodedContent =
//             content.replaceAll(r'\n', '\n').replaceAll(r'\"', '"');
//         final feed = RssFeed.parse(decodedContent);

//         // フィードの内容を表示
//         print('Feed content: ${decodedContent}');

//         // アイテムのタイトルと説明を表示
//         for (var item in feed.items ?? []) {
//           final title = utf8.decode(item.title?.codeUnits ?? []);
//           final description = item.description != null 
//               ? utf8.decode(item.description!.codeUnits) 
//               : ''; // nullの場合は空文字を代入

//           print('Item title: $title');
//           print('Item description: $description'); // 説明も出力
//         }

//         // フィルタリング処理を追加
//         setState(() {
//           _newsItems = (feed.items ?? []).where((item) {
//             final title = utf8.decode(item.title?.codeUnits ?? []);
//             final description = item.description != null 
//                 ? utf8.decode(item.description!.codeUnits) 
//                 : '';

//             // タイトルまたは説明に「大垣」が含まれているかを確認
//             return title.contains('') || description.contains('');
//           }).toList();
//         });

//         print('Total items before filtering: ${feed.items?.length}');
//         print('Total items after filtering: ${_newsItems.length}');
//       } else {
//         throw Exception('Failed to load RSS feed');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _newsItems.length,
//               itemBuilder: (context, index) {
//                 final item = _newsItems[index];
//                 return FutureBuilder<OgpData?>(
//                   future: _fetchOgpData(item.link),
//                   builder: (context, snapshot) {
//                     final ogpData = snapshot.data;
//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 10.0, vertical: 5.0),
//                       child: InkWell(
//                         onTap: () => _openArticle(item.link),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10.0),
//                                 topRight: Radius.circular(10.0),
//                               ),
//                               child: ogpData?.image != null
//                                   ? Image.network(
//                                       ogpData!.image!,
//                                       width: double.infinity,
//                                       height: 200,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Container(
//                                       height: 200,
//                                       width: double.infinity,
//                                       color: Colors.grey[300],
//                                       child: const Icon(
//                                         Icons.article,
//                                         size: 50,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     ogpData?.title ?? item.title ?? 'No title',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4.0),
//                                   Text(
//                                     ogpData?.description ??
//                                         item.pubDate?.toLocal().toString() ??
//                                         '',
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                     maxLines: 3,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   Future<OgpData?> _fetchOgpData(String? url) async {
//     if (url == null) return null;
//     try {
//       return await OgpDataExtract.execute(url);
//     } catch (e) {
//       print('Failed to fetch OGP data: $e');
//       return null;
//     }
//   }

//   void _openArticle(String? url) {
//     if (url != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebViewScreen(url: url),
//         ),
//       );
//     }
//   }
// }


























// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; 
// import 'package:ogp_data_extract/ogp_data_extract.dart';
// import 'package:webfeed_plus/domain/rss_feed.dart';
// import 'package:webfeed_plus/domain/rss_item.dart';
// import 'webview_screen.dart';

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   List<RssItem> _newsItems = [];
//   bool _isLoading = true;
//   String _selectedCity = '全て'; // 選択された市町村
//   List<String> _cities = ['全て', '大垣市', '岐阜市', '多治見市', '各務原市']; // 市町村のリスト

//   @override
//   void initState() {
//     super.initState();
//     _fetchNews();
//   }

//   Future<void> _fetchNews() async {
//     setState(() {
//       _isLoading = true;
//     });

//     const rssUrl =
//         'https://api.allorigins.win/get?url=https://news.yahoo.co.jp/rss/media/gifuweb/all.xml';

//     try {
//       final response = await http.get(Uri.parse(rssUrl));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final content = json['contents'] as String;

//         final decodedContent =
//             content.replaceAll(r'\n', '\n').replaceAll(r'\"', '"');
//         final feed = RssFeed.parse(decodedContent);

//         // フィードの内容を表示
//         print('Feed content: ${decodedContent}');

//         // アイテムのタイトルと説明を表示
//         for (var item in feed.items ?? []) {
//           final title = utf8.decode(item.title?.codeUnits ?? []);
//           final description = item.description != null 
//               ? utf8.decode(item.description!.codeUnits) 
//               : '';

//           print('Item title: $title');
//           print('Item description: $description');
//         }

//         // フィルタリング処理を追加
//         setState(() {
//           _newsItems = (feed.items ?? []).where((item) {
//             final title = utf8.decode(item.title?.codeUnits ?? []);
//             final description = item.description != null 
//                 ? utf8.decode(item.description!.codeUnits) 
//                 : '';

//             // 選択された市町村に基づいてフィルタリング
//             return (_selectedCity == '全て' || title.contains(_selectedCity) || description.contains(_selectedCity));
//           }).toList();
//         });

//         print('Total items before filtering: ${feed.items?.length}');
//         print('Total items after filtering: ${_newsItems.length}');
//       } else {
//         throw Exception('Failed to load RSS feed');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('岐阜県のニュース'),
//         actions: [
//           DropdownButton<String>(
//             value: _selectedCity,
//             items: _cities.map((String city) {
//               return DropdownMenuItem<String>(
//                 value: city,
//                 child: Text(city),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 _selectedCity = newValue ?? '全て'; // 新しい値を設定
//                 _fetchNews(); // フィルタリングを再実行
//               });
//             },
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _newsItems.length,
//               itemBuilder: (context, index) {
//                 final item = _newsItems[index];
//                 return FutureBuilder<OgpData?>(
//                   future: _fetchOgpData(item.link),
//                   builder: (context, snapshot) {
//                     final ogpData = snapshot.data;
//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 10.0, vertical: 5.0),
//                       child: InkWell(
//                         onTap: () => _openArticle(item.link),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10.0),
//                                 topRight: Radius.circular(10.0),
//                               ),
//                               child: ogpData?.image != null
//                                   ? Image.network(
//                                       ogpData!.image!,
//                                       width: double.infinity,
//                                       height: 200,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Container(
//                                       height: 200,
//                                       width: double.infinity,
//                                       color: Colors.grey[300],
//                                       child: const Icon(
//                                         Icons.article,
//                                         size: 50,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     ogpData?.title ?? item.title ?? 'No title',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4.0),
//                                   Text(
//                                     ogpData?.description ??
//                                         item.pubDate?.toLocal().toString() ??
//                                         '',
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                     maxLines: 3,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   Future<OgpData?> _fetchOgpData(String? url) async {
//     if (url == null) return null;
//     try {
//       return await OgpDataExtract.execute(url);
//     } catch (e) {
//       print('Failed to fetch OGP data: $e');
//       return null;
//     }
//   }

//   void _openArticle(String? url) {
//     if (url != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebViewScreen(url: url),
//         ),
//       );
//     }
//   }
// }





















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; 
// import 'package:ogp_data_extract/ogp_data_extract.dart';
// import 'package:webfeed_plus/domain/rss_feed.dart';
// import 'package:webfeed_plus/domain/rss_item.dart';
// import 'webview_screen.dart';

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   List<RssItem> _newsItems = [];
//   bool _isLoading = true;
//   String _selectedCity = '全て'; // 選択された市町村
//   List<String> _cities = ['全て', '大垣', '岐阜', '多治見', '各務原']; // 市町村のリスト

//   @override
//   void initState() {
//     super.initState();
//     _fetchNews();
//   }

//   Future<void> _fetchNews() async {
//     setState(() {
//       _isLoading = true;
//     });

//     const rssUrl =
//         'https://api.allorigins.win/get?url=https://news.yahoo.co.jp/rss/media/gifuweb/all.xml';

//     try {
//       final response = await http.get(Uri.parse(rssUrl));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final content = json['contents'] as String;

//         final decodedContent =
//             content.replaceAll(r'\n', '\n').replaceAll(r'\"', '"');
//         final feed = RssFeed.parse(decodedContent);

//         // フィードの内容を表示
//         print('Feed content: ${decodedContent}');

//         // アイテムのタイトルと説明を表示
//         for (var item in feed.items ?? []) {
//           final title = utf8.decode(item.title?.codeUnits ?? []);
//           final description = item.description != null 
//               ? utf8.decode(item.description!.codeUnits) 
//               : '';

//           print('Item title: $title');
//           print('Item description: $description');
//         }

//         // フィルタリング処理を追加
//         setState(() {
//           _newsItems = (feed.items ?? []).where((item) {
//             final title = utf8.decode(item.title?.codeUnits ?? []);
//             final description = item.description != null 
//                 ? utf8.decode(item.description!.codeUnits) 
//                 : '';

//             // 市町村の名前を"〇〇"（市なし）でフィルタリング
//             // 説明は"〇〇市"（市あり）でフィルタリング
//             return (_selectedCity == '全て' || 
//                     title.contains(_selectedCity) || 
//                     description.contains('市') && description.contains(_selectedCity));
//           }).toList();
//         });

//         print('Total items before filtering: ${feed.items?.length}');
//         print('Total items after filtering: ${_newsItems.length}');
//       } else {
//         throw Exception('Failed to load RSS feed');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('岐阜県のニュース'),
//         actions: [
//           DropdownButton<String>(
//             value: _selectedCity,
//             items: _cities.map((String city) {
//               return DropdownMenuItem<String>(
//                 value: city,
//                 child: Text(city),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 _selectedCity = newValue ?? '全て'; // 新しい値を設定
//                 _fetchNews(); // フィルタリングを再実行
//               });
//             },
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _newsItems.length,
//               itemBuilder: (context, index) {
//                 final item = _newsItems[index];
//                 return FutureBuilder<OgpData?>(
//                   future: _fetchOgpData(item.link),
//                   builder: (context, snapshot) {
//                     final ogpData = snapshot.data;
//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 10.0, vertical: 5.0),
//                       child: InkWell(
//                         onTap: () => _openArticle(item.link),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10.0),
//                                 topRight: Radius.circular(10.0),
//                               ),
//                               child: ogpData?.image != null
//                                   ? Image.network(
//                                       ogpData!.image!,
//                                       width: double.infinity,
//                                       height: 200,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Container(
//                                       height: 200,
//                                       width: double.infinity,
//                                       color: Colors.grey[300],
//                                       child: const Icon(
//                                         Icons.article,
//                                         size: 50,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     ogpData?.title ?? item.title ?? 'No title',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4.0),
//                                   Text(
//                                     ogpData?.description ??
//                                         item.pubDate?.toLocal().toString() ??
//                                         '',
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                     maxLines: 3,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   Future<OgpData?> _fetchOgpData(String? url) async {
//     if (url == null) return null;
//     try {
//       return await OgpDataExtract.execute(url);
//     } catch (e) {
//       print('Failed to fetch OGP data: $e');
//       return null;
//     }
//   }

//   void _openArticle(String? url) {
//     if (url != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebViewScreen(url: url),
//         ),
//       );
//     }
//   }
// }




















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; 
// import 'package:ogp_data_extract/ogp_data_extract.dart';
// import 'package:webfeed_plus/domain/rss_feed.dart';
// import 'package:webfeed_plus/domain/rss_item.dart';
// import 'webview_screen.dart';

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   List<RssItem> _newsItems = [];
//   bool _isLoading = true;
//   String _selectedCity = '全て'; // 選択された市町村
//   List<String> _cities = ['全て', '大垣', '岐阜', '多治見', '各務原']; // 市町村のリスト

//   @override
//   void initState() {
//     super.initState();
//     _fetchNews();
//   }

//   Future<void> _fetchNews() async {
//     setState(() {
//       _isLoading = true;
//     });

//     const rssUrl =
//         'https://api.allorigins.win/get?url=https://news.yahoo.co.jp/rss/media/gifuweb/all.xml';

//     try {
//       final response = await http.get(Uri.parse(rssUrl));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final content = json['contents'] as String;

//         final decodedContent =
//             content.replaceAll(r'\n', '\n').replaceAll(r'\"', '"');
//         final feed = RssFeed.parse(decodedContent);

//         // フィードの内容を表示
//         print('Feed content: ${decodedContent}');

//         // アイテムのタイトルと説明を表示
//         for (var item in feed.items ?? []) {
//           final title = utf8.decode(item.title?.codeUnits ?? []);
//           final description = item.description != null 
//               ? utf8.decode(item.description!.codeUnits) 
//               : '';

//           print('Item title: $title');
//           print('Item description: $description');
//         }

//         // フィルタリング処理を追加
//         setState(() {
//           _newsItems = (feed.items ?? []).where((item) {
//             final title = utf8.decode(item.title?.codeUnits ?? []);
//             final description = item.description != null 
//                 ? utf8.decode(item.description!.codeUnits) 
//                 : '';

//             // 岐阜市の場合、本文だけでフィルタリング
//             if (_selectedCity == '岐阜') {
//               return description.contains('岐阜市');
//             } 
//             // 他の市町村の場合、タイトルに市名が含まれ、本文には市名なしでフィルタリング
//             return (_selectedCity == '全て' || 
//                     title.contains(_selectedCity) && 
//                     description.contains(_selectedCity));
//           }).toList();
//         });

//         print('Total items before filtering: ${feed.items?.length}');
//         print('Total items after filtering: ${_newsItems.length}');
//       } else {
//         throw Exception('Failed to load RSS feed');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('岐阜県のニュース'),
//         actions: [
//           DropdownButton<String>(
//             value: _selectedCity,
//             items: _cities.map((String city) {
//               return DropdownMenuItem<String>(
//                 value: city,
//                 child: Text(city),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 _selectedCity = newValue ?? '全て'; // 新しい値を設定
//                 _fetchNews(); // フィルタリングを再実行
//               });
//             },
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _newsItems.length,
//               itemBuilder: (context, index) {
//                 final item = _newsItems[index];
//                 return FutureBuilder<OgpData?>(
//                   future: _fetchOgpData(item.link),
//                   builder: (context, snapshot) {
//                     final ogpData = snapshot.data;
//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 10.0, vertical: 5.0),
//                       child: InkWell(
//                         onTap: () => _openArticle(item.link),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10.0),
//                                 topRight: Radius.circular(10.0),
//                               ),
//                               child: ogpData?.image != null
//                                   ? Image.network(
//                                       ogpData!.image!,
//                                       width: double.infinity,
//                                       height: 200,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Container(
//                                       height: 200,
//                                       width: double.infinity,
//                                       color: Colors.grey[300],
//                                       child: const Icon(
//                                         Icons.article,
//                                         size: 50,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20.0, vertical: 10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     ogpData?.title ?? item.title ?? 'No title',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4.0),
//                                   Text(
//                                     ogpData?.description ??
//                                         item.pubDate?.toLocal().toString() ??
//                                         '',
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                     maxLines: 3,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   Future<OgpData?> _fetchOgpData(String? url) async {
//     if (url == null) return null;
//     try {
//       return await OgpDataExtract.execute(url);
//     } catch (e) {
//       print('Failed to fetch OGP data: $e');
//       return null;
//     }
//   }

//   void _openArticle(String? url) {
//     if (url != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebViewScreen(url: url),
//         ),
//       );
//     }
//   }
// }






import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:ogp_data_extract/ogp_data_extract.dart';
import 'package:webfeed_plus/domain/rss_feed.dart';
import 'package:webfeed_plus/domain/rss_item.dart';
import 'webview_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<RssItem> _newsItems = [];
  bool _isLoading = true;
  String _selectedCity = '全て'; // 選択された市町村
  List<String> _cities = [
    '全て',
    '安八町',
    '池田町',
    '揖斐川町',
    '恵那市',
    '大垣市',
    '大野町',
    '海津市',
    '各務原市',
    '笠松町',
    '可児市',
    '川辺町',
    '北方町',
    '岐南町',
    '岐阜市',
    '郡上市',
    '下呂市',
    '神戸町',
    '坂祝町',
    '白川町',
    '白川村',
    '関ケ原町',
    '関市',
    '高山市',
    '多治見市',
    '垂井町',
    '土岐市',
    '富加町',
    '中津川市',
    '羽島市',
    '東白川村',
    '飛騨市',
    '七宗町',
    '瑞浪市',
    '瑞穂市',
    '御嵩町',
    '美濃加茂市',
    '美濃市',
    '本巣市',
    '八百津町',
    '山県市',
    '養老町',
    '輪之内町',
  ];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  // 市名や町名から「市」や「町」を取り除くためのヘルパー関数
  String _normalizeCityName(String cityName) {
    return cityName.replaceAll('市', '').replaceAll('町', '').replaceAll('村', '').trim();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
    });

    const rssUrl =
        'https://api.allorigins.win/get?url=https://news.yahoo.co.jp/rss/media/gifuweb/all.xml';

    try {
      final response = await http.get(Uri.parse(rssUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final content = json['contents'] as String;

        final decodedContent =
            content.replaceAll(r'\n', '\n').replaceAll(r'\"', '"');
        final feed = RssFeed.parse(decodedContent);

        // フィルタリング処理
        setState(() {
          _newsItems = (feed.items ?? []).where((item) {
            final title = utf8.decode(item.title?.codeUnits ?? []);
            final description = item.description != null 
                ? utf8.decode(item.description!.codeUnits) 
                : '';

            final normalizedCity = _normalizeCityName(_selectedCity); // 正規化した市町村名を取得

            // フィルタリング条件
            if (_selectedCity == '全て') {
              return true; // 全てのニュースを表示
            } else if (_selectedCity == '岐阜') {
              return title.contains('岐阜') && description.contains('岐阜市');
            } else {
              return title.contains(normalizedCity) && description.contains(normalizedCity);
            }
          }).toList();
        });

        print('Total items before filtering: ${feed.items?.length}');
        print('Total items after filtering: ${_newsItems.length}');
      } else {
        throw Exception('Failed to load RSS feed');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('岐阜県のニュース'),
        actions: [
          DropdownButton<String>(
            value: _selectedCity,
            items: _cities.map((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCity = newValue ?? '全て'; // 新しい値を設定
                _fetchNews(); // フィルタリングを再実行
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _newsItems.length,
              itemBuilder: (context, index) {
                final item = _newsItems[index];
                return FutureBuilder<OgpData?>(
                  future: _fetchOgpData(item.link),
                  builder: (context, snapshot) {
                    final ogpData = snapshot.data;
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: InkWell(
                        onTap: () => _openArticle(item.link),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: ogpData?.image != null
                                  ? Image.network(
                                      ogpData!.image!,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.article,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ogpData?.title ?? item.title ?? 'No title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    ogpData?.description ??
                                        item.pubDate?.toLocal().toString() ??
                                        '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Future<OgpData?> _fetchOgpData(String? url) async {
    if (url == null) return null;
    try {
      return await OgpDataExtract.execute(url);
    } catch (e) {
      print('Failed to fetch OGP data: $e');
      return null;
    }
  }

  void _openArticle(String? url) {
    if (url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url),
        ),
      );
    }
  }
}
