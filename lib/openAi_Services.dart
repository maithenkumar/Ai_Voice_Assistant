import "dart:convert";

import "package:chap_gpt_app/screets.dart";
import "package:http/http.dart" as http;

class OpenAiServices {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $openApiKey"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                'role': 'user',
                'content':
                    'Doe this message want to genarate an Ai Picture ,image,art or anything similar? $prompt . simply answer with a Yes or No',
              }
            ],
          }));

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["Choices"][0]["message"]["content"];
        content = content.trim();
        // messages.add({
        //   'role':
        // });

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await ChatGPTAPI(prompt);
            return res;
        }
      }
      return "An internal error occurred";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> ChatGPTAPI(String prompt) async {
    messages.add({'roll': 'user', 'content': prompt});

    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $openApiKey"
          },
          body: jsonEncode({"model": "gpt-3.5-turbo", "messages": messages}));

      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["Choices"][0]["message"]["content"];
        content = content.trim();
        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
        // switch (content) {
        //   case "Yes":
        //   case "yes":
        //   case 'Yes':
        //   case "yes":
        //     final res = await dallEAPI(prompt);
        //     return res;
        //   default:
        //     final res = await ChatGPTAPI(prompt);
        //     return res;
        // }
      }
      return "An internal error occurred";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({'roll': 'user', 'content': prompt});

    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/images/generations"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $openApiKey"
          },
          body: jsonEncode({
            'prompt': prompt,
            'n': 1,
          }));

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)["data"][0]['url'];
        imageUrl = imageUrl.trim();
        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
        // switch (content) {
        //   case "Yes":
        //   case "yes":
        //   case 'Yes':
        //   case "yes":
        //     final res = await dallEAPI(prompt);
        //     return res;
        //   default:
        //     final res = await ChatGPTAPI(prompt);
        //     return res;
        // }
      }
      return "An internal error occurred";
    } catch (e) {
      return e.toString();
    }
  }
}
