import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DashboardProvider extends ChangeNotifier {
  Map<String, dynamic>? userProfile;
  Map<String, dynamic>? quote;
  bool isLoadingUser = false;
  bool isLoadingQuote = false;
  String? errorUser;
  String? errorQuote;

  final Map<String, String> _headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    'Accept': 'application/json',
  };

  Future<void> fetchRandomUser() async {
    isLoadingUser = true;
    errorUser = null;
    notifyListeners();
    
    try {
      final response = await http.get(
        Uri.parse('https://randomuser.me/api/'),
        headers: _headers,
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          userProfile = data['results'][0];
        } else {
          throw Exception('Empty results from API');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching user: $e');
      errorUser = e.toString();
      // Fallback user so the UI isn't stuck
      userProfile = {
        'name': {'first': 'Guest', 'last': 'User'},
        'email': 'guest@example.com',
        'location': {'city': 'Digital', 'country': 'World'},
        'phone': '000-000-0000',
        'picture': {
          'large': 'https://ui-avatars.com/api/?name=Guest+User&size=128',
          'thumbnail': 'https://ui-avatars.com/api/?name=Guest+User&size=48',
        }
      };
    } finally {
      isLoadingUser = false;
      notifyListeners();
    }
  }

  Future<void> fetchDailyQuote() async {
    isLoadingQuote = true;
    errorQuote = null;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse('https://zenquotes.io/api/random'),
        headers: _headers,
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final item = data[0];
          quote = {
            'content': item['q'],
            'author': item['a'],
          };
        }
      }
    } catch (e) {
      debugPrint('Error fetching quote: $e');
      errorQuote = e.toString();
      quote = {
        'content': 'The only way to do great work is to love what you do.',
        'author': 'Steve Jobs'
      };
    } finally {
      isLoadingQuote = false;
      notifyListeners();
    }
  }

  void initialize() {
    if (userProfile == null) fetchRandomUser();
    if (quote == null) fetchDailyQuote();
  }
}
