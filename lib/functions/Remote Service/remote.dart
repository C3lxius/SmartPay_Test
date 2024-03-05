import 'dart:convert';

import 'package:http/http.dart' as http;

// Initialise HTTP Client
var client = http.Client();

class Remote {
  // Base Url
  String baseUrl = "https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1";

  // Function to Get Email token for verification
  Future verifyEmail(String email) async {
    var url = Uri.parse('$baseUrl/auth/email');

    try {
      var response = await client
          .post(
            url,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return {
          'code': 200,
          'token': result['data']['token'],
        };
      } else {
        return {
          'code': response.statusCode,
          'message': jsonDecode(response.body)['message'],
        };
      }
    } on Exception {
      return {
        'code': 500,
        'message': "An Error Occured. Please try again later",
      };
    }
  }

  // Function to Verify the Token
  Future verifyToken(String email, String token) async {
    var url = Uri.parse('$baseUrl/auth/email/verify');

    try {
      var response = await client
          .post(
            url,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode({"email": email, "token": token}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return {
          'code': 200,
          'email': result['data']['email'],
        };
      } else {
        return {
          'code': response.statusCode,
          'message': jsonDecode(response.body)['message'],
        };
      }
    } on Exception {
      return {
        'code': 500,
        'message': "An Error Occured. Please try again later",
      };
    }
  }

  // Sign Up Function
  Future register(Map<String, String> userInfo) async {
    var url = Uri.parse('$baseUrl/auth/register');

    try {
      var response = await client
          .post(
            url,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(userInfo),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return {
          'code': 200,
          'user': result['data']['user'],
          'token': result['data']['token']
        };
      } else {
        return {
          'code': response.statusCode,
          'message': jsonDecode(response.body)['message'],
        };
      }
    } on Exception {
      return {
        'code': 500,
        'message': "An Error Occured. Please try again later",
      };
    }
  }

  // Log in Function
  Future login(Map<String, String> userInfo) async {
    var url = Uri.parse('$baseUrl/auth/login');

    try {
      var response = await client
          .post(
            url,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(userInfo),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return {
          'code': 200,
          'user': result['data']['user'],
          'token': result['data']['token']
        };
      } else {
        return {
          'code': response.statusCode,
          'message': jsonDecode(response.body)['message'],
        };
      }
    } on Exception {
      return {
        'code': 500,
        'message': "An Error Occured. Please try again later",
      };
    }
  }

  // Get Secret Phrase Function
  Future getSecret(String token) async {
    var url = Uri.parse('$baseUrl/dashboard');

    try {
      var response = await client.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result['message'];
      } else {
        return "";
      }
    } on Exception {
      return "";
    }
  }

  // Logout Function
  Future logout() async {
    var url = Uri.parse('$baseUrl/auth/logout');
    try {
      var response = await client.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }
}
