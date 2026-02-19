import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart' as prov;

import '../../auth/provider/auth_provider.dart';

/// Manages the welcome message fetched from Firestore for the current user.
class HomeProvider extends prov.ChangeNotifier {
  final FirebaseFirestore _firestore;

  HomeProvider({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  String? _message;
  bool _isLoading = false;
  String? _errorMessage;

  String? get message => _message;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches the personalised welcome message for [uid] from Firestore.
  ///
  /// Document path: `users/{uid}`  — field: `message`
  Future<void> fetchWelcomeMessage(String uid) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      _message = doc.data()?['message'] as String? ??
          'Welcome! No personalised message yet.';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
