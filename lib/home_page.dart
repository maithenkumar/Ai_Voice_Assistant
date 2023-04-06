import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'fuaturs_box.dart';
import 'openAi_Services.dart';
import 'pallete.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? generatedContent;
  String? generatedImageUrl;
  FlutterTts flutterTts = FlutterTts();
  String lastWords = "";
  final OpenAiServices openAiServices = OpenAiServices();
  final speechtoText = SpeechToText();
  int start = 200;

  int delay = 200;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechtoText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechtoText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.

  stopListening() async {
    await speechtoText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechtoText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BounceInDown(child: const Text("Allen")),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                          color: Pallete.assitantCircleColor,
                          shape: BoxShape.circle),
                      margin: const EdgeInsets.only(top: 4),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/virtualAssistant.png"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // chat bubble
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ).copyWith(
                    top: 30,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Pallete.borderColor),
                      borderRadius: BorderRadius.circular(20).copyWith(
                        topLeft: Radius.zero,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      generatedContent == null
                          ? "Good Morning, what task I can do for you?"
                          : generatedContent!,
                      style: TextStyle(
                          color: Pallete.mainFontColor,
                          fontSize: generatedContent == null ? 25 : 18,
                          fontFamily: "Cera pro"),
                    ),
                  ),
                ),
              ),
            ),
            if (generatedImageUrl != null)
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!),
                  )),
            //sugestion,

            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 22,
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Here ae a few fuatures",
                    style: TextStyle(
                        fontFamily: "Cera Pro",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Pallete.mainFontColor),
                  ),
                ),
              ),
            ),
            //featurs
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(microseconds: start),
                    child: const FuatureBox(
                        color: Pallete.firstSuggestionBoxColor,
                        headerText: "ChatGPT",
                        discriptionText:
                            "A samarter way to organized and informed with chatGPT "),
                  ),
                  SlideInLeft(
                    delay: Duration(microseconds: start + delay),
                    child: const FuatureBox(
                        color: Pallete.secondSuggestionBoxColor,
                        headerText: "Dall-E",
                        discriptionText:
                            "Get imspired and stay creative with your personal assistant powered by Dall-E "),
                  ),
                  SlideInLeft(
                    delay: Duration(microseconds: start + 2 * delay),
                    child: const FuatureBox(
                        color: Pallete.secondSuggestionBoxColor,
                        headerText: "Smart Voice Assistant",
                        discriptionText:
                            "Get the best of both with a voice Assistant powered by Dall-E chatGPT"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(microseconds: start + 2 * delay),
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: () async {
            if (await speechtoText.hasPermission &&
                speechtoText.isNotListening) {
              await startListening();
            } else if (speechtoText.isListening) {
              final speech = await openAiServices.isArtPromptAPI(lastWords);
              if (speech.contains("https")) {
                generatedContent = null;
                generatedImageUrl = speech;
                setState(() {});
              } else {
                generatedContent = speech;
                generatedImageUrl = null;
                setState(() {});
              }
              await systemSpeak(speech);

              await stopListening();
            } else {
              initSpeechToText();
              // print(lastWords);
            }
          },
          child: Icon(
              speechtoText.isListening ? Icons.stacked_bar_chart : Icons.mic),
        ),
      ),
    );
  }
}
