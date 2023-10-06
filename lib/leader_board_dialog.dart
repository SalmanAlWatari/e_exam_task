import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

leaderboardDialog({
  required BuildContext context,
  required bool isError,
  required var score,
  required int correctAnswers,
  required int allQuestCount,
  GoogleSignInAccount? user,
  String? errorMessage,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: SingleChildScrollView(
          child: Container(
            height: (MediaQuery.of(context).size.height * 0.60),
            width: (MediaQuery.of(context).size.width * 0.90),
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5))
            ),
            child: Column(children: [

              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close_sharp),
                  tooltip: 'close',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              (user == null
                  ? const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 50,
                    )
                  : GoogleUserCircleAvatar(identity: user)),
              Text(
                (user != null ? (user.displayName ?? '') : "-"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                //(user != null ? (user.displayName ?? '') : "-"),
                (user != null ? user.email : "-"),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                errorMessage ?? "",
                style: const TextStyle(color: Colors.black),
              ),
              const Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        score.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                      const Text("Score",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "#$correctAnswers",
                        style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                      const Text("Correct",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("#${allQuestCount - correctAnswers}",
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(0.9))),
                      const Text("Error",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  )
                ],
              ),
            ]),
          ),
        ));
      });
}
