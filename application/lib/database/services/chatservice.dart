// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

// GET CHATS BY ID
Future<List<dynamic>> getChatsByID(String iduser) async {
  final url = Uri.parse('http://10.0.2.2:5000/chats/user/$iduser');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Future.error("Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    return Future.error("Error: $e");
  }
}

// GET MESSAGES BY CHAT ID
Future<List<dynamic>> getMessagesByChatId(int chatId) async {
  final url = Uri.parse('http://10.0.2.2:5000/chats/user/messages/$chatId');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Future.error("Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    return Future.error("Error: $e");
  }
}

// SEND MESSAGE TO CHAT
Future<Map<String, dynamic>> sendMessageToChat(
    int chatId, String userId, String message) async {
  final url = Uri.parse('http://10.0.2.2:5000/chat/sendquestion');
  Map<String, dynamic> data = {
    'chatId': chatId,
    'userId': userId,
    'message': message,
  };

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}

Future<List<dynamic>> createNewChat(String userId) async {
  final url = Uri.parse('http://10.0.2.2:5000/chat/create');
  Map<String, dynamic> data = {
    'userId': userId,
  };

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}

// DELETE CHAT BY ID
Future<void> deleteChatById(int chatId) async {
  final url = Uri.parse('http://10.0.2.2:5000/chat/delete/$chatId');

  try {
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Chat deleted successfully');
    } else {
      throw Exception("Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
