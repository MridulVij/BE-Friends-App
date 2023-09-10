import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/home/home.dart';
import 'package:pinput/pinput.dart';
class AuthOTP extends StatefulWidget {
  const AuthOTP({super.key});

  @override
  State<AuthOTP> createState() => _AuthOTPState();
}

class _AuthOTPState extends State<AuthOTP> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/auth/login.png',
                height: 190,
                width: 190,
              ),
              SizedBox(height: 10,),

              Text(
                'OTP Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:  22,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Enter the OTP you recieved on the phone number you entered',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Pinput(
                length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,

              ),


              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    // enteredOtp = enteredOtp.trim(); // Trim any leading/trailing whitespace from the entered OTP
                    // enteredOtp=otpController.text;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardMain()));
                  },
                  child: Text("Verify OTP",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context,'login_page');
                    },
                    child: Text(
                      "Change your Phone Number ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}

