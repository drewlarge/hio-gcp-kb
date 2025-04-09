import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kDebugMode; // To check if running in debug mode

// Use environment variable (passed via --dart-define=API_GATEWAY_URL=...) for production,
// otherwise default to the deployed gateway URL for easier debug/dev builds.
const String _apiGatewayBaseUrl = String.fromEnvironment(
  'API_GATEWAY_URL',
  // Default value points to the deployed gateway
  defaultValue: 'https://real-estate-kb-gateway-3figwaat.ue.gateway.dev',
);

class ApiService {
  /**
   * Submits a query to the backend LLM via the API Gateway.
   */
  Future<Map<String, dynamic>> submitQuery(String query) async {
    // Our OpenAPI spec defines the path as /query
    final Uri queryUri = Uri.parse('$_apiGatewayBaseUrl/query');

    if (kDebugMode) {
      print('Submitting query to backend: $query at $queryUri');
    }

    try {
      final response = await http.post(
        queryUri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': query,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (kDebugMode) {
          print('Received response from backend: $data');
        }
        return data;
      } else {
        print('API request failed with status ${response.statusCode}');
        print('Response body: ${response.body}');
        // Consider creating custom exception types
        throw Exception('Failed to submit query. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting query: $e');
      // Re-throw the error to be handled by the caller (e.g., UI)
      throw Exception('Failed to submit query: $e');
    }
  }

  // TODO: Add functions for other API endpoints (e.g., document upload)
} 