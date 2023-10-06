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
                height: (MediaQuery.of(context).size.height * 0.70),
                width: (MediaQuery.of(context).size.width * 0.90),
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(errorMessage ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold), ),
                        IconButton(
                          icon: const Icon(Icons.close_sharp),
                          tooltip: 'close',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),

                      ],
                    ),
                  ),

                  (user == null
                      ? const CircleAvatar(
                    backgroundImage: NetworkImage(
                      // "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1331&q=80"
                        "assets/photo-1511367461989-f85a21fda167.jfif"),
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