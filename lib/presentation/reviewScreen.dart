import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../domain/model/feedback.dart';

class ReviewScreenWidget extends StatefulWidget{
  @override
  _state createState() => _state();
}

class _state extends State<ReviewScreenWidget>{
  final TextEditingController _reviewText = TextEditingController();
  int currentReview = 0;
  int reviewCount = 0;

  List<FeedbackItem> feedbacks = [FeedbackItem(id: "0", name: "невозможно загрузить отзывы", text: "")];

  StreamSubscription? subscription;
  @override void initState() {
    Repository.getFeedback();
    subscription = Repository.feedbacksController.stream.listen((item) =>
    {
      setState(() {
        feedbacks = item;
        reviewCount = feedbacks.length;
        currentReview = feedbacks.length-1;
        subscription?.cancel();
      })
    }
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/reviewImage.png"),
            Expanded(child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(51, 0, 0, 0)
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(feedbacks[currentReview].name+":", style: const TextStyle(fontSize: 24), textAlign: TextAlign.left ,),
                  const SizedBox(height: 10),
                  Text(feedbacks[currentReview].text, style: const TextStyle(fontSize: 20))
                ],
              )
            )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: (){
                  setState(() {
                    _nextReview();
                  });
                }, icon: const Icon(Icons.arrow_back_ios_rounded, size: 40), color: const Color.fromARGB(255, 72, 216, 22)),
                IconButton(onPressed: (){
                  Scaffold.of(context).showBottomSheet<void>(
                        (BuildContext context) {
                      return Container(
                        height: 300,
                        color: const Color.fromARGB(240, 0, 0, 0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Добавить отзыв', style: TextStyle(color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 10),
                              Expanded(child: TextField(controller: _reviewText, maxLines: null, expands: true,keyboardType: TextInputType.multiline, style: const TextStyle(color: Colors.white), cursorColor: Colors.white,decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(3))
                                )

                              ),)),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                child: const Text('ОТПРАВИТЬ ОТЗЫВ'),
                                style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),
                                onPressed: () {
                                  if(_reviewText.text.length>5) {
                                    Repository.addFeedback(_reviewText.text);
                                  }else{
                                    print("short text");
                                  }
                                  _reviewText.clear();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }, icon: const Icon(Icons.add, size: 40), color: const Color.fromARGB(255, 72, 216, 22)),
                IconButton(onPressed: (){
                  setState(() {
                    _prevReview();
                  });
                }, icon: const Icon(Icons.arrow_forward_ios_rounded, size: 40), color: const Color.fromARGB(255, 72, 216, 22))
              ],
            )
          ],
        )
    );
  }

  void _nextReview(){
    currentReview++;
    if(currentReview>=reviewCount){
      currentReview = 0;
    }
  }
  void _prevReview(){
    currentReview--;
    if(currentReview<0){
      currentReview = reviewCount-1;
    }
  }
}