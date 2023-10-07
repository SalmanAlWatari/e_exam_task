//import 'package:flutter/cupertino.dart';
import 'package:e_exam_task/blocs/google_user_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//dart file contain leader_board_dialog
import 'leader_board_dialog.dart';

//Parameters that holding the Values of Radio options
enum OptionsQuesOne { one, two }

enum OptionsQuesTwo { one, two }

enum OptionsQuesThree { one, two }

/*
Int Array that holding the  indexes of the correct Answers in Radio options
   OptionsQuesOne { one, two }      =>       [1]
   OptionsQuesTwo { one, two }      =>       [0]
   OptionsQuesThree { one, two }    =>       [0]   then [1, 0, 0]
 */
const indexesOfCorrectAnswers = [1, 0, 0];

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly'
]);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var score = 0.0;
  int correctAnswers = 0;
  //int _selectedView = 0;

  OptionsQuesOne? _answerOne;
  OptionsQuesTwo? _answerTwo;
  OptionsQuesThree? _answerThree;

  @override
  void initState() {
    super.initState();

    context
        .read<GoogleUserBloc>()
        .add(SetUserEvent(user: _googleSignIn.currentUser));
    _googleSignIn.onCurrentUserChanged.listen((account) {
      context.read<GoogleUserBloc>().add(SetUserEvent(user: account));
    });

    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final stylePrimary = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary, fontSize: 25
            //color: Colors.black,
            );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "E-Exam Task By Salman",
          style: stylePrimary,
        ),
      ),
      //body: (_selectedView == 0) ? quesWidget() : const Text("leaderboard"),
      body: quesWidget(),
    );
  }

  Widget quesWidget() {
    GoogleSignInAccount? currentUser;

    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<GoogleUserBloc, GoogleUserState>(
            builder: (context, state) {
              if (kDebugMode) {
                print("**state");
                print(state);
              }

              if (state is GoogleUserUpdate && state.user != null) {
                if (kDebugMode) {
                  print("**state");
                  print(state.user);
                }

                currentUser = state.user;
                return Center(child: accountGoogleInfo2(context, currentUser));
              } else {
                return Center(child: signInGoogleButton());
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Answer Questions",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: FractionalOffset.topLeft,
                  child: Text(
                    " 1- One plus One ? ",
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<OptionsQuesOne>(
                      value: OptionsQuesOne.one,
                      groupValue: _answerOne,
                      onChanged: (OptionsQuesOne? value) {
                        setState(() {
                          _answerOne = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Five',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Radio<OptionsQuesOne>(
                      value: OptionsQuesOne.two,
                      groupValue: _answerOne,
                      onChanged: (OptionsQuesOne? value) {
                        setState(() {
                          _answerOne = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Two',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  thickness: 0.5,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.black,
                ),
                const Align(
                  alignment: FractionalOffset.topLeft,
                  child: Text(
                    " 2- Two plus Two ? ",
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<OptionsQuesTwo>(
                      value: OptionsQuesTwo.one,
                      groupValue: _answerTwo,
                      onChanged: (OptionsQuesTwo? value) {
                        setState(() {
                          _answerTwo = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Four',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Radio<OptionsQuesTwo>(
                      value: OptionsQuesTwo.two,
                      groupValue: _answerTwo,
                      onChanged: (OptionsQuesTwo? value) {
                        setState(() {
                          _answerTwo = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Eight',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  thickness: 0.5,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.black,
                ),
                const Align(
                  alignment: FractionalOffset.topLeft,
                  child: Text(
                    " 2- Three plus Three ? ",
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<OptionsQuesThree>(
                      value: OptionsQuesThree.one,
                      groupValue: _answerThree,
                      onChanged: (OptionsQuesThree? value) {
                        setState(() {
                          _answerThree = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Six',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Radio<OptionsQuesThree>(
                      value: OptionsQuesThree.two,
                      groupValue: _answerThree,
                      onChanged: (OptionsQuesThree? value) {
                        setState(() {
                          _answerThree = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Seven',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  thickness: 0.5,
                  indent: 70,
                  endIndent: 70,
                  color: Colors.black,
                ),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      submitAnswers(currentUser);
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text('Submit'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      submitOrDownloadExamResult(
                          isSubmit: false, currentUser: currentUser);
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('download my result'),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton signInGoogleButton() {
    return ElevatedButton(
      onPressed: _handleSignIn,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/google_logo.png",
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text("Sign In"),
            ],
          )),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  submitAnswers(GoogleSignInAccount? currentUser) {
    var scoreTmp = 0.0;
    int correctTmp = 0;
    var gradePerQuest = 33.33333333333333;
    //var errorMessage = "";

    /*
       calculate The Score or Grade Of Exam
    */

    scoreTmp +=
        (_answerOne?.index == indexesOfCorrectAnswers[0]) ? gradePerQuest : 0;
    scoreTmp +=
        (_answerTwo?.index == indexesOfCorrectAnswers[1]) ? gradePerQuest : 0;
    scoreTmp +=
        (_answerThree?.index == indexesOfCorrectAnswers[2]) ? gradePerQuest : 0;

    /*
       calculate The number or the count for the Answers that is correct
    */
    correctTmp += (_answerOne?.index == indexesOfCorrectAnswers[0]) ? 1 : 0;
    correctTmp += (_answerTwo?.index == indexesOfCorrectAnswers[1]) ? 1 : 0;
    correctTmp += (_answerThree?.index == indexesOfCorrectAnswers[2]) ? 1 : 0;

    setState(() {
      score = scoreTmp;
      correctAnswers = correctTmp;
      submitOrDownloadExamResult(isSubmit: true, currentUser: currentUser);
    });
  }

  submitOrDownloadExamResult(
      {required bool isSubmit, GoogleSignInAccount? currentUser}) {
    //check if _currentUser is null ,, Sing In Required because of using the email as ID in the document in Firebase.
    if (currentUser == null) {
      showLeaderboardDialog(
          isError: true,
          errMsg: "Sing In Required, can't Saving or Loading data!",
          currentUser: currentUser);
      return;
    }

    var db = FirebaseFirestore.instance;

    /* if Submit is clicked the exam result will be saved to Firebase store then show result.

       else the result downloading using email as ID of the Doc from Firebase store so showing result if exist.
       if not found, will display message no data yet
    */
    if (isSubmit) {
      final data = <String, dynamic>{
        "score": score,
        "correct": correctAnswers,
        "gmail": currentUser.email
      };

      db
          .collection("users")
          .doc(currentUser.email)
          .set(data)
          .then((value) => showLeaderboardDialog(
              isError: false, errMsg: "", currentUser: currentUser))
          .onError((e, _) => showLeaderboardDialog(
              isError: true,
              errMsg: "Error Saving data  $e!!!",
              currentUser: currentUser));
    } else {
      db.collection("users").doc(currentUser.email).get().then((event) {
        if (kDebugMode) {
          print(event.data());
        }
        var data_ = event.data();

        setState(() {
          if (data_ != null) {
            score = data_["score"];
            correctAnswers = data_["correct"];
            showLeaderboardDialog(
                isError: false, errMsg: "", currentUser: currentUser);
          } else {
            showLeaderboardDialog(
                isError: true,
                errMsg: "No Data yet! for current user.",
                currentUser: currentUser);
          }
        });
      }).onError((e, _) => showLeaderboardDialog(
          isError: true,
          errMsg: "Error Loading data  $e!!!",
          currentUser: currentUser));
    }
  }

  showLeaderboardDialog(
      {required bool isError,
      String? errMsg,
      GoogleSignInAccount? currentUser}) {
    leaderboardDialog(
      context: context,
      isError: isError,
      score: score,
      correctAnswers: correctAnswers,
      allQuestCount: indexesOfCorrectAnswers.length,
      user: currentUser,
      errorMessage: errMsg,
    );
  }

  Widget accountGoogleInfo2(BuildContext context, GoogleSignInAccount? user) {
    if (user != null) {
      return Column(
        children: [
          GoogleUserCircleAvatar(identity: user),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              user.displayName ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              user.email,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    } else {
      return signInGoogleButton();
    }
  }
}
