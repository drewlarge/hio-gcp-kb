import 'package:http/http.dart' as http;
import 'dart:convert';

// TODO: Replace with actual API Gateway endpoint from environment variable or config
const String _apiBaseUrl = String.fromEnvironment(
  'API_GATEWAY_URL',
  defaultValue: 'http://localhost:3001/api', // Default for local dev
);

class ApiService {
  /**
   * Placeholder function to simulate submitting a query to the backend.
   * Replace with actual API call logic.
   */
  Future<Map<String, dynamic>> submitQuery(String query) async {
    print('Submitting query to backend: $query');
    final Uri queryUri = Uri.parse('$_apiBaseUrl/llm-query');

    try {
      // final response = await http.post(
      //   queryUri,
      //   headers: {
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(<String, String>{
      //     'query': query,
      //   }),
      // );

      // if (response.statusCode == 200) {
      //   return jsonDecode(response.body) as Map<String, dynamic>;
      // } else {
      //   print('API request failed with status ${response.statusCode}');
      //   print('Response body: ${response.body}');
      //   throw Exception('Failed to submit query. Status code: ${response.statusCode}');
      // }

      // --- Mock Response for now ---
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      return {
        'response': 'Mock response for query: "$query" from Flutter',
        'sources': ['doc_flutter.pdf', 'flutter_website.com/article'],
      };
      // --- End Mock Response ---

    } catch (e) {
      print('Error submitting query: $e');
      throw Exception('Failed to submit query: $e');
    }
  }

  // TODO: Add functions for other API endpoints (e.g., document upload)
} 