import 'package:get/get.dart';

class MainTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "ETPoliceApp": "ETPoliceApp",

          //spalsh
          "Location Permission": "Location Permission",
          "We need location permission to assign your reports to the nearest police station.":
              "We need location permission to assign your reports to the nearest police station.",
          "OK": "OK",
          "ETPoliceApp 2024. All rights reserved":
              "ETPoliceApp 2024. All rights reserved",

          // sign up
          "Create an account": "Create an account",
          "Thank you for making our society safer.":
              "Thank you for making our society safer.",
          "Phone 9******": "Phone 9******",
          "Pin": "Pin",

          "Already Have an Account ?": "Already Have an Account ?",
          "I accept the terms and conditions":
              "I accept the terms and conditions",

          "Please Provide valid Phone Number!":
              "Please Provide valid Phone Number!",

          "Please enter a pin": "Please enter a pin",
          "Pin must be exactly 6 digits long":
              "Pin must be exactly 6 digits long",
          "Pin must contain only numeric digits":
              "Pin must contain only numeric digits",
          "Error": "Error",
          "Please check the terms and conditions":
              "Please check the terms and conditions",
          "Success": "Success",
          "You have successfully registered":
              "You have successfully registered",

          "Phone number has already been taken":
              "Phone number has already been taken",
          "failed, try again later": "failed, try again later",
          "Invalid OTP": "Invalid OTP",
          "Something went wrong": "Something went wrong",
          "OTP resent": "OTP resent",

          //sign in
          "Welcome Back": "Welcome Back",

          "Log In": "Log In",

          "Forgot your pin ?": "Forgot your pin ?",
          "Don't have an account?": "Don't have an account?",
          "Sign up": "Sign up",

          "Please enter pin": "Please enter pin",
          "The provided credentials are incorrect.":
              "The provided credentials are incorrect.",
          "Your phone number is not verified":
              "Your phone number is not verified",

          //Forgot pin
          "Forgot pin": "Forgot pin",
          "Please enter your Phone number": "Please enter your Phone number",
          "You will receive a code to create a new pin.":
              "You will receive a code to create a new pin.",
          "Please, input you phone number": "Please, input you phone number",
          "Send": "Send",
          "We have sent Otp": "We have sent Otp",
          "An error occurred, try again later":
              "An error occurred, try again later",
          "Password Reset": "Password Reset",
          "Password Don't Match": "Password Don't Match",
          "Verification": "Verification",
          "Enter the OTP that is  sent to your phone number":
              "Enter the OTP that is  sent to your phone number",
          "pin": "pin",
          "Confirm pin": "Confirm pin",
          "please Enter OTP": "please Enter OTP",
          "Submit": "Submit",

          //Home page
          "Send a Report": "Send a Report",
          "Important Note:": "Important Note:",
          "The app serves as a illegal activity awareness tool, not a direct channel for reporting crimes. While the app does not consider submitted reports as formal police reports, it gathers information to enhance users' awareness of illegal activities.":
              "The app serves as a illegal activity awareness tool, not a direct channel for reporting crimes. While the app does not consider submitted reports as formal police reports, it gathers information to enhance users' awareness of illegal activities.",
          "You can add multi media files into one report":
              "You can add multi media files into one report",
          "Photo": "Photo",
          "Video": "Video",
          "Audio": "Audio",
          "Link": "Link",
          "File": "File",

          "Announcements": "Announcements",
          "News": "News",
          "Road Closure": "Road Closure",
          "Wanted Persons": "Wanted Persons",
          "Missing Persons or Item": "Missing Persons or Item",
          "Read More": "Read More",

          "People of Determination": "People of Determination",
          "Request a \n  Direct  Call": "Request a \n  Direct  Call",
          "Record Sign \n  Language Video": "Record Sign \n  Language Video",

          "Please attach at least one audio, image, link, or video.":
              "Please attach at least one audio, image, link, or video.",
          "Please select Date and Time.": "Please select Date and Time.",
          "Failed to send report. Please try again later.":
              "Failed to send report. Please try again later.",
          "Report Sent": "Report Sent",
          "Unexpected response from the server.":
              "Unexpected response from the server.",
          "The request timed out. Please try again.":
              "The request timed out. Please try again.",
          "An unexpected error occurred. Please try again later.":
              "An unexpected error occurred. Please try again later.",

          //Road Closure page
          "City": "City",
          "From": "From",
          "To": "To",
          "From Date and time": "From Date and time",
          "To Date and time": "To Date and time",
          "Remark": "Remark",
          "View": "View",

          //Wanted Persons page

          "Gender": "Gender",
          "Wanted": "Wanted",
          "Retry": "Retry",
          "Please Check Your Internet Connection and Try Again":
              "Please Check Your Internet Connection and Try Again",
          "Network Error": "Network Error",
          "Full name": "Full name",
          "Age": "Age",
          "Dangerous": "Dangerous",

          //Missing Persons or Item page

          "Missing Persons": "Missing Persons",
          "Missing": "Missing",
          "Contact Phone number": "Contact Phone number",
          "Contact Email": "Contact Email",

          // TabView
          "Reports": "Reports",
          "No internet connection": "No internet connection",

          "Incident Time": "Incident Time",
          "Incident Place": "Incident Place",
          "Select Incident Time and place": "Select Incident Time and place",
          "No date and time selected": "No date and time selected",
          "Selected date and time:": "Selected date and time:",
          "Contact me for clarification": "Contact me for clarification",
          "Time selected": "Time selected",
          "Place selected": "Place selected",
          "Change": "Change",

          //mapview
          "Select Incident Place": "Select Incident Place",
          "Select Location": "Select Location",

          //SendPhoto
          "Invalid File!!": "Invalid File!!",
          "Please select an image.": "Please select an image.",
          "Please select a non-empty image file less than 20 MB":
              "Please select a non-empty image file less than 20 MB",
          "You can upload 5 Photo files": "You can upload 5 Photo files",
          "Photo Upload": "Photo Upload",

          "Take Photo": "Take Photo",
          "Gallery": "Gallery",
          "Upload Photos": "Upload Photos",
          "Close": "Close",

          "Maximum upload size: 20 MB.": "Maximum upload size: 20 MB.",

          //send video
          "Please select a Video.": "Please select a Video.",
          "Please select a non-empty Video file less than 50 MB":
              "Please select a non-empty Video file less than 50 MB",

          "Video Upload": "Video Upload",

          "Take Video": "Take Video",
          "Maximum upload size: 50 MB.": "Maximum upload size: 50 MB.",
          "Upload Video": "Upload Video",
          "You can upload 5 Video files": "You can upload 5 Video files",

          //Send Audio
          "You can upload 5 audio files": "You can upload 5 audio files",
          "Audio Upload": "Audio Upload",
          "Start Recording": "Start Recording ",
          "Stop Recording": "Stop Recording",
          "Pick from File": "Pick from File",
          "Please select an audio file.": "Please select an audio file.",

          "Please record an audio file.": "Please record an audio file.",
          "Please record a non-empty audio file less than 5 MB.":
              "Please record a non-empty audio file less than 5 MB.",

          "Please select a non-empty audio file less than 5 MB.":
              "Please select a non-empty audio file less than 5 MB.",
          "Upload Audio": "Upload Audio",
          "You can upload 5 Audio files": "You can upload 5 Audio files",
          "Maximum upload size: 5 MB.": "Maximum upload size: 5 MB.",
          "By cliking start record  you can automatically start recording":
              "By cliking start record  you can automatically start recording",

          //send link
          "You can upload 5 Links": "You can upload 5 Links",
          "Add link": "Add link",
          "Enter URL": "Enter URL",

          "Type URLL": "Type URL",
          "Cancel": "Cancel",

          "Link Upload": "Link Upload",

          "Invalid URL": "Invalid URL",

          //Send File page
          "File Upload": "File Upload",
          "Upload Files": "Upload Files",
          "You can upload 5  files": "You can upload 5  files",

          "Insert File": "Insert File",
          "File Too Large!!": "File Too Large!!",
          "Please select a file smaller than 20 MB":
              "Please select a file smaller than 20 MB",
          "Please select a PDF or DOC file": "Please select a PDF or DOC file",

          // Main Page
          "Press back again to exit": "Press back again to exit",
          "Home": "Home",

          "Setting": "Setting",

          // Report page
          "You have no report.": "You have no report.",
          "Start protecting your society by reporting it to us through photo, video, or audio.":
              "Start protecting your society by reporting it to us through photo, video, or audio.",
          "hour": "hour",
          "Rating sent": "Rating sent",
          "Rating not sent": "Rating not sent",
          "Assigned": "Assigned",
          "Closed": "Closed",
          "Deferred": "Deferred",
          "In Progress": "In Progress",
          "Not Assigned": "Not Assigned",
          "Referred": "Referred",
          "Unknown": "Unknown",

          //Ticket Details
          "Ticket Details": "Ticket Details",
          "hours ago": "hours ago",
          "We sincerely appreciate your report":
              "We sincerely appreciate your report",
          "Description": "Description",
          "Kindly rate your experience": "Kindly rate your experience",
          "Rate": "Rate",
          "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our ":
              "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our",
          " page. Thank you.": "page. Thank you.",
          "Uploaded Videos": "Uploaded Videos",
          "Uploaded Links": "Uploaded Links",
          "Uploaded Photos": "Uploaded Photos",
          "Uploaded Audios": "Uploaded Audios",
          "Happy": "Happy",
          "Good": "Good",
          "Fair": "Fair",
          "Sad": "Sad",

          //Setting page

          "Language": "Language",
          "Change Language": "Change Language",
          "Account": "Account",
          "Manage your Account": "Manage your Account",
          "About us": "About us",
          "Learn more about us": "Learn more about us",
          "Contact us": "Contact us",
          "Get in touch with us": "Get in touch with us",
          "Terms and Conditions": "Terms and Conditions",
          "Read the terms and conditions": "Read the terms and conditions",
          "Privacy Policy": "Privacy Policy",
          "View our privacy policy": "View our privacy policy",
          "Rate us": "Rate us",
          "Leave a rating and review": "Leave a rating and review",
          "Logout": "Logout",
          "Sign out of your account": "Sign out of your account",

          //lanaguage
          "Languages": "Languages",
          "Select your preferred language": "Select your preferred language",
          "Set Language": "Set Language",
          "Amharic": "Amharic",
          "English": "English",
          "Affan Oromo": "Affan Oromo",
          "Tigirigna": "Tigirigna",
          "Somali": "Somali",

          //Account
          "Account Status": "Account Status",
          "Profile": "Profile",
          "Change Pin": "Change Pin",
          "Remove Acccount": "Remove Acccount",

          //Chanage pin

          "Please enter your old Pin and a new Pin":
              "Please enter your old Pin and a new Pin",
          "Old Pin": "Old Pin",
          "New Pin": "New Pin",
          "Confirm new Pin": "Confirm new Pin",
          "Update Pin": "Update Pin",
          "pin updated": "pin updated",
          "pin not updated please check your old pin":
              "pin not updated please check your old pin",
          "pin Don't Match": "pin Don't Match",

          //remove account
          "Remove Account": "Remove Account",
          "Select the reason for deleting their account":
              "Select the reason for deleting their account",

          "Write your reason": "Write your reason",
          "No longer needed": "No longer needed",
          "Privacy concern": "Privacy concern",
          "Account security concerns": "Account security concerns",
          "Too many notifications": "Too many notifications",
          "Difficulty using the app": "Difficulty using the app",
          "Other": "Other",

          //About us
          "Address": "Address",
          "Call Us": "Call Us",
          "Email Us": "Email Us",
          "FAQ": "FAQ",

          // Contact us
          "Contact Us": "Contact Us",
          "General Inquiry": "General Inquiry",
          "App Issue": "App Issue",
          "Know my ticket status": "Know my ticket status",
          "Grivenances": "Grivenances",

          "We are here to help": "We are here to help",

          "What can we help you with?": "What can we help you with?",
          "Select an option": "Select an option",
          "Tell us more about your problem": "Tell us more about your problem",

          //Logout
          "Log out": "Log out",
          "Are you sure you want to log out?":
              "Are you sure you want to log out?",

          //Profile
          "Update": "Update",

          //Notification
          "You have no notifications": "You have no notifications",
          "Notification": "Notification",

          //create an account

          "Please create an account or login":
              "Please create an account or login",
          "Account Not Found": "Account Not Found",
          "Sign Up": "Sign Up",
          "Sign In": "Sign In",

          //help
          "help": "help",
          "Coming soon": "Coming soon",
        },
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //Amharic
        //አማርኛ
        'am': {
          "ETPoliceApp": "የዜጎች ተሳትፎ",

          //spalsh
          //መግቢያ ገጽ
          "Location Permission": "ሎኬሽን ፍቀድ",
          "We need location permission to assign your reports to the nearest police station.":
              "ሪፖርትዎን በአቅራቢያ ላለ ፖሊስ ጣቢያ ለማስተላለፍ የሎኬሽን ፈቃድ ይፍቀዱ",
          "OK": "እሺ",
          "ETPoliceApp 2024. All rights reserved":
              "ETPoliceApp 2016. መብቱ በህግ የተጠበቀ ነው",

          // sign up
          // ይመዝገቡ
          "Create an account": "መለያ ይፍጠሩ",
          "Thank you for making our society safer.":
              "ማህበረሰቡ ሰላም እንዲሆን ስላደረጉ እናመሰናለን",
          "Phone 9******": "ስልክ ቁጥር 9******",
          "Pin": "የይለፍ ቃል",

          "Already Have an Account ?": "ያስገቡት መለያ የተመዘገበ ነው",
          "I accept the terms and conditions": "በደምብ እና ሁኔታዎች እስማማለሁ",

          "Please Provide valid Phone Number!": "እባክዎ ትክክለኛ ስልክ ቁጥር ያስገቡ!",

          "Please enter a pin": "እባክዎ የይለፍ ቃል ያስገቡ",
          "Pin must be exactly 6 digits long":
              "የይለፍ ቃል እርዝመት የ6 ቁጥሮች ቅንብር ብቻ ነው",
          "Pin must contain only numeric digits":
              "የይለፍ ቃል ቅንብር ቁጥር ብቻ መያዝ አለበት",
          "Error": "የተሳሳተ",
          "Please check the terms and conditions": "እባክዎን የአገልግሎት  ውሎችን  ያረጋግጡ",
          "Success": "ተሳክቷል",
          "You have successfully registered": "በተሳካ ሁኔታ ተመዝግበዋል",

          "Phone number has already been taken": "የተጠቀሙት ስልክ ቁጥር የተመዘገበ ነው",
          "failed, try again later": "አልተሳካም፤ እባክዎ እንደገና ይሞክሩ",
          "Invalid OTP": "ልክ ያልሆነ የሚስጥር ቁጥር ተጠቅመዋል",
          "Something went wrong": "ስህተት ተፈጥሯል",
          "OTP resent": "የሚስጥር ቁጥርዎን ይቀይሩ",

          //sign in
          //ይግቡ
          "Welcome Back": "እንኳን ደህና መጡ",

          "Log In": "ይግቡ",

          "Forgot your pin ?": "የይለፍ ቃል እረስተዋል?",
          "Don't have an account?": "መለያ የለዎትም?",
          "Sign up": "ይመዝገቡ",

          "Please enter pin": "የይለፍ ቃል ያስገቡ",
          "The provided credentials are incorrect.": "ያስገቡት የይለፍ ቃል የተሳሳተ ነው",
          "Your phone number is not verified": "የስልክ ቁጥርዎ አልተረጋገጠም",

          //Forgot pin
          //የተረሳ የይለፍ ቃል
          "Forgot pin": "የይለፍ ቃል ረስተዋል?",
          "Please enter your Phone number": "እባክዎ ስልክ ቁጥርዎን ያስገቡ",
          "You will receive a code to create a new pin.":
              "አዲስ የይለፍ ቃል ለመፍጠር የሚስጥር ቁጥር ይደርስዎታል",
          "Please, input you phone number": "እባክዎ ስልክ ቁጥርዎን ያስገቡ",
          "Send": "ላክ",
          "We have sent Otp": "የሚስጥር ቁጥር ተልኳል",
          "An error occurred, try again later": "ስህተት ተፈጥሯል፤ እንደገና ይሞክሩ",
          "Password Reset": "የይለፍ ቃል ቀይር",
          "Password Don't Match": "የይለፍ ቃል አይመሳሰልም",
          "Verification": "አረጋግጥ",
          "Enter the OTP that is  sent to your phone number":
              "ወደ ስልክዎ የተላከውን የሚስጥር ቁጥር ያስገቡ",
          "pin": "የይለፍ ቃል",
          "Confirm pin": "የይለፍ ቃል ያረጋግጡ",
          "please Enter OTP": "እባክዎ የሚስጥር ቁጥር ያስገቡ",
          "Submit": "ላክ",

          //Home page
          //ዋና ገጽ
          "Send a Report": "ሪፖርት ላክ",

          "⁠The app serves as a illegal activity awareness tool, not a direct channel for reporting crimes. While the app does not consider submitted reports as formal police reports, it gathers information to enhance users' awareness of illegal activities.":
              "መተግበሪያው እንደ ህገወጥ እንቅስቃሴ ግንዛቤ መሳሪያ እንጂ ወንጀሎችን ሪፖርት ለማድረግ ቀጥተኛ ቻናል አይደለም። መተግበሪያው የቀረቡ ሪፖርቶችን እንደ መደበኛ የፖሊስ ሪፖርቶች ባይቆጥርም፣ የተጠቃሚዎችን ህገወጥ ተግባራት ግንዛቤ ለማሳደግ መረጃ ይሰበስባል።",
          "Important Note:": "ጠቃሚ ማስታወሻ፡-",
          "You can add multi media files into one report":
              "በአንድ ጊዜ ብዙ የሚዲያ ፋይሎችን ሪፖርት መላክ ይችላሉ",
          "Photo": "ፎቶ",
          "Video": "ቪዲዮ",
          "Audio": "ድምጽ",
          "Link": "ሊንክ",
          "File": "ፋይል",

          "Announcements": "ማስታወቂያ",
          "News": "ዜና",
          "Road Closure": "የሚዘጉ መንገዶች",
          "Wanted Persons": "ተፈላጊ ሰው",
          "Missing Persons or Item": "የጠፋ ሰው ወይም ንብረት",
          "Read More": "ተጨማሪ ያንብቡ",

          "People of Determination": "አካል ጉዳተኞች/ ልዩ ፍላጎት",
          "Request a \n  Direct  Call": "በቀጥታ ይደውሉ",
          "Record Sign \n  Language Video": "የምልክት ቋንቋ ይቅዱ",

          "Please attach at least one audio, image, link, or video.":
              "እባክዎን ቢያንስ አንድ የድምጽ፣ የፎቶ፣ ሊንክ ወይም ቪድዮ ይጨምሩ",
          "Please select Date and Time.": "እባክዎን ቀን እና ሰዓት ይምረጡ",
          "Failed to send report. Please try again later.":
              "ሪፖርቱ አልተላከም፤ እባክዎ እንደገና ይሞክሩ",
          "Report Sent": "ሪፖርቱ በተሳካ ሁኔታ ተልኳል",
          "Unexpected response from the server.": "ስህተት ተከስቷል",
          "The request timed out. Please try again.": "ሰዓት አልቋል፤ እንደገና ይሞክሩ",
          "An unexpected error occurred. Please try again later.":
              "ያልተጠበቀ ስህተት ተከስቷል። እባክዎ ቆየት ብለው ይሞክሩ",

          //Road Closure page
          //የተዘጉ መንገዶች ገጽ
          "City": "ከተማ",
          "From": "ከ",
          "To": "እስከ",
          "From Date and time": "ከቀን እና ሰዓት ጀምሮ",
          "To Date and time": "እስክ ከቀን እና ሰዓት",
          "Remark": "አስተያየት",
          "View": "ተመልከት",

          //Wanted Persons page
          //የሚፈለጉ ሰዎች ገጽ
          "Gender": "ፆታ",
          "Wanted": "ተፈላጊ",
          "Retry": "እንደገና ይሞክሩ",
          "Please Check Your Internet Connection and Try Again":
              "እባክዎ የኢንተርኔት አገልግሎት መኖሩን ያረጋግጡ፤ ከሌለ እንደገና ይሞክሩ ",
          "Network Error": "የኔትዎርክ ችግር ተከስቷል",
          "Full name": "ሙሉ ስም",
          "Age": "ዕድሜ",
          "Dangerous": "አደገኛ",

          //Missing Persons or Item page
          //የጠፉ ሰዎች ወይ እቃ ገጽ
          "Missing Persons": "የጠፋ ሰው",
          "Missing": "የጠፋ",
          "Contact Phone number": "ስልክ ቁጥር",
          "Contact Email": "ኢሜል",

          // TabView
          // የእይታ ገጽ
          "Reports": "ሪፖርቶች",
          "No internet connection": "የኢንተርኔት ግንኙነት የለም",
          "Incident Time": " የክስተት ሰዓት",
          "Incident Place": "የክስተት ቦታ",
          "Select Incident Time and place": "የአደጋ ጊዜ እና ቦታ ይምረጡ",
          "No date and time selected": "ቀን እና ሰዓት አልተመረጠም",
          "Selected date and time:": "የተመረጠ ቀንና ስዓት",
          "Contact me for clarification": "ለበለጠ መረጃ እኛን ያግኙኝ",

          "Time selected": "ስዓት ተመርጧል",
          "Place selected": "ቦታ ተመርጧል",
          "Change": "ለውጥ",

          //mapview
          "Select Incident Place": "የክስተት ቦታን ይምረጡ",
          "Select Location": "አካባቢን ይምረጡ",

          //SendPhoto
          //ፎቶ ላክ
          "Invalid File!!": "ትክክል ያልሆነ ፎቶ!!",
          "Please select an image.": "እባክዎን ፎቶ ይምረጡ",
          "Please select a non-empty image file less than 20 MB":
              "እባክዎ ከ20 ሜጋ ባይት ያልበለጠ ፎቶ ይምረጡ",
          "You can upload 5 Photo files": "5 የፎቶ ፋይሎችን መጫን ይችላሉ",
          "Photo Upload": "የተጫኑ ፎቶዎች",

          "Take Photo": "ፎቶ አንሳ",
          "Gallery": "ከክምችት",
          "Upload Photos": "ፎቶ ይጫኑ",
          "Close": "ዝጋ",

          "Maximum upload size: 20 MB.": "ከፍተኛ ፎቶ ፋይል የመጫን መጠን: 20 MB.",

          //send video
          //ቪዲዮ ላክ
          "Please select a Video.": "እባክዎን ቪዲዮ ይምረጡ",
          "Please select a non-empty Video file less than 50 MB":
              "እባክዎን ከ50 ሜጋ ባይት ያልበለጠ የቪዲዮ ፋይል ይምረጡ",

          "Video Upload": "ቪዲዮ የተጫኑ",

          "Take Video": "ቪዲዮ ይቅዱ",
          "Maximum upload size: 50 MB.": "መጫን የሚችሉት የፋይል መጠን 50ሚጋ ባይት ብቻ ነው",
          "Upload Video": "ቪዲዮ ይጫኑ",
          "You can upload 5 Video files": "እስከ አምስት የቪዲዮ ፋይል መጫን ይችላሉ",

          //Send Audio
          //ድምጽ ላክ
          "You can upload 5 audio files": "እስከ አምስት የፎቶ ፋይል መጫን ይችላሉ",
          "Audio Upload": "ድምጽ ይጫኑ",
          "Start Recording": "መቅዳት ጀምር",
          "Stop Recording": "መቅዳት አቁም",
          "Pick from File": "ከፋይል ይጫኑ",
          "Please select an audio file.": "እባክዎ የድምጽ ፋይል ይምረጡ",

          "Please record an audio file.": "እባክዎ የድምጽ ፋይል ይቅዱ",
          "Please record a non-empty audio file less than 5 MB.":
              "እባክዎ ከ5ሜጋ ባይት ያልበለጠ የድምጽ ፋይል ይቅዱ",

          "Please select a non-empty audio file less than 5 MB.":
              "እባክዎ ከ5ሜጋ ባይት ያልበለጠ የድምጽ ፋይል ይምረጡ",
          "Upload Audio": "የድምጽ ፋይል ይጫኑ",
          "You can upload 5 Audio files": "እስከ አምስት የድምጽ ፋይል መጫን ይችላሉ",
          "Maximum upload size: 5 MB.": "መጫን የሚችሉት የድምጽ ፋይል መጠን 5 ሚጋ ባይት ብቻ ነው",
          "By cliking start record  you can automatically start recording":
              "መቅዳት ጀምር የሚለውን በመጫን ወደዛው መቅዳት ማስጀመር ይችላሉ",

          //send link
          //ሊንክ ይላኩ
          "You can upload 5 Links": "5 ሊንኮችን መጫን ይችላሉ",
          "Add link": "ሊንክ ይጨምሩ",
          "Enter URL": "URL ያስገቡ",

          "Type URLL": "URL ይጻፉ",
          "Cancel": "ሰርዝ",

          "Link Upload": "ሊንክ ይጫኑ",

          "Invalid URL": "ትክክል ያልሆን URL",

          //Send File page
          //ፋይል ይላኩ
          "File Upload": "ፋይል ይጫሉ",
          "Upload Files": "የተጫኑ ፋይሎች",
          "You can upload 5 files": "እስክ 5 ፋይሎች መጫን ይችላሉ",

          "Insert File": "ፋይል ያስገቡ",
          "File Too Large!!": "ፋይሉ ትልቅ ነው",
          "Please select a file smaller than 20 MB":
              "እባክዎ ከ20 ሜጋ ባይት ያልበለጠ የፋይል መጠን ይምረጡ",
          "Please select a PDF or DOC file": "እባክዎ የPDF ወይም የDOC ፋይል ይምረጡ",

          // Main Page
          // ዋና ገጽ
          "Press back again to exit": "ለመውጣት ተመለስ የሚላውን ይጫኑ",
          "Home": "ዋና ገጽ",

          "Setting": "መቸት",

          // Report page
          // ሪፖርት ገጽ
          "You have no report.": "ሪፖርት የለም",
          "Start protecting your society by reporting it to us through photo, video, or audio.":
              "የፎቶ፣ የቪዲዮ ወይም የድምጽ ሪፖርት በመላክ የማህበረሰቡን ሰላም ለረጋግጡ አሁኑኑ ይግምሩ",
          "hour": "ሰዓት",
          "Rating sent": "ደረጃ ላክ",
          "Rating not sent": "ደረጃ አልተላከም",
          "Assigned": "ተመድቧል",
          "Closed": "ተዘግቷል",
          "Deferred": "እንደገና ተመልሷል",
          "In Progress": "በሂደት ላይ",
          "Not Assigned": "አልተመደበም",
          "Referred": "ተላልፏል",
          "Unknown": "አልታወቀም",

          //Ticket Details
          "Ticket Details": "የትኬት ዝርዝር",
          "hours ago": "ከሰዓታት በፊት",
          "We sincerely appreciate your report": "ሪፖርት ስላደረጉ ከልብ እናመሰግናለን",
          "Description": "መግለጫ",
          "Kindly rate your experience": "ከተሞክሮዎ አንጻር ደረጃ ይስጡ",
          "Rate": "ደረጃ ስጥ",
          "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our ":
              "የእኛን መተግበሪያ በመጠቀምዎ መጥፎ ተሞክሮ ስላጋጠመዎት እናዝናለን። ጉዳዩን በእኛ በኩል ሊገልጹልን ይፈልጋሉ?",
          " page. Thank you.": "ገጽ እናመሰግናለን",
          "Uploaded Videos": "የተጫነ ቪዲዮ",
          "Uploaded Links": "የተጫነ ሊንክ",
          "Uploaded Photos": "የተጫነ ፎቶ",
          "Uploaded Audios": "የተጫነ ድምጽ",
          "Happy": "ደስተኛ",
          "Good": "ጥሩ",
          "Fair": "መጠነኛ",
          "Sad": "መጥፎ",

          //Setting page
          //መቸት ገጽ

          "Language": "ቋንቋ",
          "Change Language": "ቋንቋ ለውጥ",
          "Account": "መለያ ቁልፍ",
          "Manage your Account": "መለያዎን ያስተዳድሩ",
          "About us": "ስለ እና",
          "Learn more about us": "ስለኛ የበለጠ ይወቁ",
          "Contact us": "ያግኙን",
          "Get in touch with us": "ከእኛ ጋር ይገናኙ",
          "Terms and Conditions": "አተገባበርና ​​መመሪያ",
          "Read the terms and conditions": "ውሎችን እና ሁኔታዎችን ያንብቡ",
          "Privacy Policy": "የግላዊነት ፖሊሲ",
          "View our privacy policy": "የግላዊነት ውሉን ይመልከቱ",
          "Rate us": "ይመዝኑን",
          "Leave a rating and review": "ደረጃ ይተዉ እና ይገምግሙ",
          "Logout": "ውጣ",
          "Sign out of your account": "ከመለያዎ ይውጡ",

          //lanaguage
          //ቋንቋ
          "Languages": "ቋንቋዎች",
          "Select your preferred language": "የሚፈልጉትን ቋንቋ  ይምረጡ",
          "Set Language": "ቋንቋ ያስተካክሉ",
          "Amharic": "አማርኛ",
          "English": "እንግሊዘኛ",
          "Affan Oromo": "አፋን ኦሮሞ",
          "Tigirigna": "ትግሪኛ",
          "Somali": "ሱማሊኛ",

          //Account
          //መለያ
          "Account Status": "የመለያ ሁኔታ",
          "Profile": "ግለ ታሪክ",
          "Change Pin": "የይለፍ ቃል ይቀይሩ",
          "Remove Acccount": "መለያ ያስወግዱ",

          //Chanage pin
          //የይለፍ ቃል ቀይር

          "Please enter your old Pin and a new Pin": "እባክዎ አሮጌውን የይለፍ ቃል ያስገቡ",
          "Old Pin": "አሮጌ የይለፍ ቃል",
          "New Pin": "አዲስ ቃል",
          "Confirm new Pin": "አዲሱን የይለፍ ቃል ያረጋግጡ",
          "Update Pin": "የይለፍ ቃል አሻሽል",
          "pin updated": "የይለፍ ቃሉ ተሻሽሏል",
          "pin not updated please check your old pin":
              "የይለፍ ቃሉ አልተሻሻለም እባክዎ አሮጌውን የይለፍ ቃል ያስታውሱ",
          "pin Don't Match": "የይለፍ ቃሉ አይመሳሰልም",

          //remove account
          //መለያ ሰርዝ
          "Remove Account": "መለያ ሰርዝ",
          "Select the reason for deleting their account":
              "መለያ የሰረዙበትን ምክንያት ይምረጡ",

          "Write your reason": "ምክንያትዎን ይጻፉ",
          "No longer needed": "ከእንግዲህ አያስፈልግም",
          "Privacy concern": "የግላዊነት ስጋት",
          "Account security concerns": "የመለያ ደህንነት ስጋቶች",
          "Too many notifications": "በጣም ብዙ ማሳወቂያዎች",
          "Difficulty using the app": "መተግበሪያውን ለመጠቀም አስቸጋሪነት",
          "Other": "ሌላ",

          //About us
          //ስለኛ
          "Address": "አድራሻ",
          "Call Us": "ይደውሉልን",
          "Email Us": "ኢሜል ይላኩ",
          "FAQ": "በተደጋጋሚ የተጠየቁ ጥያቄዎች",

          // Contact us
          // ያግኙን
          "Contact Us": "ያግኙን",
          "General Inquiry": "አጠቃላይ ምርመራ",
          "App Issue": "የመተግበሪያ ጉዳይ",
          "Know my ticket status": "የትኬት ሁኔታዬን እወቅ",
          "Grivenances": "ቅረታዎች",

          "We are here to help": "እርሶን ለመርዳት ዝግጁ ነኝ",

          "What can we help you with?": "ምን እንርዳዎ?",
          "Select an option": "አማራጮችን ይምረጡ",
          "Tell us more about your problem": "ስለ ችግርዎ የበለጠ ይንገሩን",

          //Logout
          // መውጫ
          "Log out": "ውጣ",
          "Are you sure you want to log out?": "እርግጠኛ ነዎት መውጣት ይፈልጋሉ?",

          //Profile
          //ግለ ታሪክ
          "Update": "አሻሽል",

          //Notification
          //ማሳወቂያ
          "You have no notifications": "የአሳውቁኝ መልዕክት አልደረስዎትም",
          "Notification": "ምሳወቂያ",

          //create an account

          "Please create an account or login":
              "እባክዎ አካውንት ይፍጠሩ ወይም ወደ መለያዎ ይግቡ",
          "Account Not Found": "መለያ አልተገኘም።",
          "Sign Up": "አካውንት ይፍጠሩ",
          "Sign In": "ይግቡ",

          //help
          "help": "ይግቡ",
          "Coming soon": "በቅርብ ቀን ይጠብቁን",

          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          //oromogna
        },
        'or': {
          "ETPoliceApp": "Hirmaannaa Lammii",
          //spalsh
          "Location Permission": "Location Permission",
          "We need location permission to assign your reports to the nearest police station.":
              "We need location permission to assign your reports to the nearest police station.",
          "OK": "OK",
          "ETPoliceApp 2024. All rights reserved":
              "ETPoliceApp 2024. All rights reserved",

          // sign up
          "Create an account": "Create an account",
          "Thank you for making our society safer.":
              "Thank you for making our society safer.",
          "Phone 9******": "Phone 9******",
          "Pin": "Pin",

          "Already Have an Account ?": "Already Have an Account ?",
          "I accept the terms and conditions":
              "I accept the terms and conditions",

          "Please Provide valid Phone Number!":
              "Please Provide valid Phone Number!",

          "Please enter a pin": "Please enter a pin",
          "Pin must be exactly 6 digits long":
              "Pin must be exactly 6 digits long",
          "Pin must contain only numeric digits":
              "Pin must contain only numeric digits",
          "Error": "Error",
          "Please check the terms and conditions":
              "Please check the terms and conditions",
          "Success": "Success",
          "You have successfully registered":
              "You have successfully registered",

          "Phone number has already been taken":
              "Phone number has already been taken",
          "failed, try again later": "failed, try again later",
          "Invalid OTP": "Invalid OTP",
          "Something went wrong": "Something went wrong",
          "OTP resent": "OTP resent",

          //sign in
          "Welcome Back": "Welcome Back",

          "Log In": "Log In",

          "Forgot your pin ?": "Forgot your pin ?",
          "Don't have an account?": "Don't have an account?",
          "Sign up": "Sign up",

          "Please enter pin": "Please enter pin",
          "The provided credentials are incorrect.":
              "The provided credentials are incorrect.",
          "Your phone number is not verified":
              "Your phone number is not verified",

          //Forgot pin
          "Forgot pin": "Forgot pin",
          "Please enter your Phone number": "Please enter your Phone number",
          "You will receive a code to create a new pin.":
              "You will receive a code to create a new pin.",
          "Please, input you phone number": "Please, input you phone number",
          "Send": "Send",
          "We have sent Otp": "We have sent Otp",
          "An error occurred, try again later":
              "An error occurred, try again later",
          "Password Reset": "Password Reset",
          "Password Don't Match": "Password Don't Match",
          "Verification": "Verification",
          "Enter the OTP that is  sent to your phone number":
              "Enter the OTP that is  sent to your phone number",
          "pin": "pin",
          "Confirm pin": "Confirm pin",
          "please Enter OTP": "please Enter OTP",
          "Submit": "Submit",

          //Home page
          "Send a Report": "Send a Report",
          "You can add multi media files into one report":
              "You can add multi media files into one report",
          "Photo": "Photo",
          "Video": "Video",
          "Audio": "Audio",
          "Link": "Link",
          "File": "File",

          "Announcements": "Announcements",
          "News": "News",
          "Road Closure": "Road Closure",
          "Wanted Persons": "Wanted Persons",
          "Missing Persons or Item": "Missing Persons or Item",
          "Read More": "Read More",

          "People of Determination": "People of Determination",
          "Request a \n  Direct  Call": "Request a \n  Direct  Call",
          "Record Sign \n  Language Video": "Record Sign \n  Language Video",

          "Please attach at least one audio, image, link, or video.":
              "Please attach at least one audio, image, link, or video.",
          "Please select Date and Time.": "Please select Date and Time.",
          "Failed to send report. Please try again later.":
              "Failed to send report. Please try again later.",
          "Report Sent": "Report Sent",
          "Unexpected response from the server.":
              "Unexpected response from the server.",
          "The request timed out. Please try again.":
              "The request timed out. Please try again.",
          "An unexpected error occurred. Please try again later.":
              "An unexpected error occurred. Please try again later.",

          //Road Closure page
          "City": "City",
          "From": "From",
          "To": "To",
          "From Date and time": "From Date and time",
          "To Date and time": "To Date and time",
          "Remark": "Remark",
          "View": "View",

          //Wanted Persons page

          "Gender": "Gender",
          "Wanted": "Wanted",
          "Retry": "Retry",
          "Please Check Your Internet Connection and Try Again":
              "Please Check Your Internet Connection and Try Again",
          "Network Error": "Network Error",
          "Full name": "Full name",
          "Age": "Age",
          "Dangerous": "Dangerous",

          //Missing Persons or Item page

          "Missing Persons": "Missing Persons",
          "Missing": "Missing",
          "Contact Phone number": "Contact Phone number",
          "Contact Email": "Contact Email",

          // TabView
          "Reports": "Reports",
          "No internet connection": "No internet connection",

          "Incident Time": "Incident Time",
          "Select Incident Time": "Select Incident Time",
          "No date and time selected": "No date and time selected",
          "Selected date and time:": "Selected date and time:",
          "Contact me for clarification": "Contact me for clarification",

          //SendPhoto
          "Invalid File!!": "Invalid File!!",
          "Please select an image.": "Please select an image.",
          "Please select a non-empty image file less than 20 MB":
              "Please select a non-empty image file less than 20 MB",
          "You can upload 5 Photo files": "You can upload 5 Photo files",
          "Photo Upload": "Photo Upload",

          "Take Photo": "Take Photo",
          "Gallery": "Gallery",
          "Upload Photos": "Upload Photos",
          "Close": "Close",

          "Maximum upload size: 20 MB.": "Maximum upload size: 20 MB.",

          //send video
          "Please select a Video.": "Please select a Video.",
          "Please select a non-empty Video file less than 50 MB":
              "Please select a non-empty Video file less than 50 MB",

          "Video Upload": "Video Upload",

          "Take Video": "Take Video",
          "Maximum upload size: 50 MB.": "Maximum upload size: 50 MB.",
          "Upload Video": "Upload Video",
          "You can upload 5 Video files": "You can upload 5 Video files",

          //Send Audio
          "You can upload 5 audio files": "You can upload 5 audio files",
          "Audio Upload": "Audio Upload",
          "Start Recording": "Start Recording ",
          "Stop Recording": "Stop Recording",
          "Pick from File": "Pick from File",
          "Please select an audio file.": "Please select an audio file.",

          "Please record an audio file.": "Please record an audio file.",
          "Please record a non-empty audio file less than 5 MB.":
              "Please record a non-empty audio file less than 5 MB.",

          "Please select a non-empty audio file less than 5 MB.":
              "Please select a non-empty audio file less than 5 MB.",
          "Upload Audio": "Upload Audio",
          "You can upload 5 Audio files": "You can upload 5 Audio files",
          "Maximum upload size: 5 MB.": "Maximum upload size: 5 MB.",
          "By cliking start record  you can automatically start recording":
              "By cliking start record  you can automatically start recording",

          //send link
          "You can upload 5 Links": "You can upload 5 Links",
          "Add link": "Add link",
          "Enter URL": "Enter URL",

          "Type URLL": "Type URL",
          "Cancel": "Cancel",

          "Link Upload": "Link Upload",

          "Invalid URL": "Invalid URL",

          //Send File page
          "File Upload": "File Upload",
          "Upload Files": "Upload Files",
          "You can upload 5  files": "You can upload 5  files",

          "Insert File": "Insert File",
          "File Too Large!!": "File Too Large!!",
          "Please select a file smaller than 20 MB":
              "Please select a file smaller than 20 MB",
          "Please select a PDF or DOC file": "Please select a PDF or DOC file",

          // Main Page
          "Press back again to exit": "Press back again to exit",
          "Home": "Home",

          "Setting": "Setting",

          // Report page
          "You have no report.": "You have no report.",
          "Start protecting your society by reporting it to us through photo, video, or audio.":
              "Start protecting your society by reporting it to us through photo, video, or audio.",
          "hour": "hour",
          "Rating sent": "Rating sent",
          "Rating not sent": "Rating not sent",
          "Assigned": "Assigned",
          "Closed": "Closed",
          "Deferred": "Deferred",
          "In Progress": "In Progress",
          "Not Assigned": "Not Assigned",
          "Referred": "Referred",
          "Unknown": "Unknown",

          //Ticket Details
          "Ticket Details": "Ticket Details",
          "hours ago": "hours ago",
          "We sincerely appreciate your report":
              "We sincerely appreciate your report",
          "Description": "Description",
          "Kindly rate your experience": "Kindly rate your experience",
          "Rate": "Rate",
          "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our ":
              "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our",
          " page. Thank you.": "page. Thank you.",
          "Uploaded Videos": "Uploaded Videos",
          "Uploaded Links": "Uploaded Links",
          "Uploaded Photos": "Uploaded Photos",
          "Uploaded Audios": "Uploaded Audios",
          "Happy": "Happy",
          "Good": "Good",
          "Fair": "Fair",
          "Sad": "Sad",

          //Setting page

          "Language": "Language",
          "Change Language": "Change Language",
          "Account": "Account",
          "Manage your Account": "Manage your Account",
          "About us": "About us",
          "Learn more about us": "Learn more about us",
          "Contact us": "Contact us",
          "Get in touch with us": "Get in touch with us",
          "Terms and Conditions": "Terms and Conditions",
          "Read the terms and conditions": "Read the terms and conditions",
          "Privacy Policy": "Privacy Policy",
          "View our privacy policy": "View our privacy policy",
          "Rate us": "Rate us",
          "Leave a rating and review": "Leave a rating and review",
          "Logout": "Logout",
          "Sign out of your account": "Sign out of your account",

          //lanaguage
          "Languages": "Languages",
          "Select your preferred language": "Select your preferred language",
          "Set Language": "Set Language",
          "Amharic": "Amharic",
          "English": "English",
          "Affan Oromo": "Affan Oromo",
          "Tigirigna": "Tigirigna",
          "Somali": "Somali",

          //Account
          "Account Status": "Account Status",
          "Profile": "Profile",
          "Change Pin": "Change Pin",
          "Remove Acccount": "Remove Acccount",

          //Chanage pin

          "Please enter your old Pin and a new Pin":
              "Please enter your old Pin and a new Pin",
          "Old Pin": "Old Pin",
          "New Pin": "New Pin",
          "Confirm new Pin": "Confirm new Pin",
          "Update Pin": "Update Pin",
          "pin updated": "pin updated",
          "pin not updated please check your old pin":
              "pin not updated please check your old pin",
          "pin Don't Match": "pin Don't Match",

          //remove account
          "Remove Account": "Remove Account",
          "Select the reason for deleting their account":
              "Select the reason for deleting their account",

          "Write your reason": "Write your reason",
          "No longer needed": "No longer needed",
          "Privacy concern": "Privacy concern",
          "Account security concerns": "Account security concerns",
          "Too many notifications": "Too many notifications",
          "Difficulty using the app": "Difficulty using the app",
          "Other": "Other",

          //About us
          "Address": "Address",
          "Call Us": "Call Us",
          "Email Us": "Email Us",
          "FAQ": "FAQ",

          // Contact us
          "Contact Us": "Contact Us",
          "General Inquiry": "General Inquiry",
          "App Issue": "App Issue",
          "Know my ticket status": "Know my ticket status",
          "Grivenances": "Grivenances",

          "We are here to help": "We are here to help",

          "What can we help you with?": "What can we help you with?",
          "Select an option": "Select an option",
          "Tell us more about your problem": "Tell us more about your problem",

          //Logout
          "Log out": "Log out",
          "Are you sure you want to log out?":
              "Are you sure you want to log out?",

          //Profile
          "Update": "Update",

          //Notification
          "You have no notifications": "You have no notifications",
          "Notification": "Notification",
        },
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'ti': {
          "ETPoliceApp": "የዜጎች ተሳትፎ",
          //spalsh
          "Location Permission": "Location Permission",
          "We need location permission to assign your reports to the nearest police station.":
              "We need location permission to assign your reports to the nearest police station.",
          "OK": "OK",
          "ETPoliceApp 2024. All rights reserved":
              "ETPoliceApp 2024. All rights reserved",

          // sign up
          "Create an account": "Create an account",
          "Thank you for making our society safer.":
              "Thank you for making our society safer.",
          "Phone 9******": "Phone 9******",
          "Pin": "Pin",

          "Already Have an Account ?": "Already Have an Account ?",
          "I accept the terms and conditions":
              "I accept the terms and conditions",

          "Please Provide valid Phone Number!":
              "Please Provide valid Phone Number!",

          "Please enter a pin": "Please enter a pin",
          "Pin must be exactly 6 digits long":
              "Pin must be exactly 6 digits long",
          "Pin must contain only numeric digits":
              "Pin must contain only numeric digits",
          "Error": "Error",
          "Please check the terms and conditions":
              "Please check the terms and conditions",
          "Success": "Success",
          "You have successfully registered":
              "You have successfully registered",

          "Phone number has already been taken":
              "Phone number has already been taken",
          "failed, try again later": "failed, try again later",
          "Invalid OTP": "Invalid OTP",
          "Something went wrong": "Something went wrong",
          "OTP resent": "OTP resent",

          //sign in
          "Welcome Back": "Welcome Back",

          "Log In": "Log In",

          "Forgot your pin ?": "Forgot your pin ?",
          "Don't have an account?": "Don't have an account?",
          "Sign up": "Sign up",

          "Please enter pin": "Please enter pin",
          "The provided credentials are incorrect.":
              "The provided credentials are incorrect.",
          "Your phone number is not verified":
              "Your phone number is not verified",

          //Forgot pin
          "Forgot pin": "Forgot pin",
          "Please enter your Phone number": "Please enter your Phone number",
          "You will receive a code to create a new pin.":
              "You will receive a code to create a new pin.",
          "Please, input you phone number": "Please, input you phone number",
          "Send": "Send",
          "We have sent Otp": "We have sent Otp",
          "An error occurred, try again later":
              "An error occurred, try again later",
          "Password Reset": "Password Reset",
          "Password Don't Match": "Password Don't Match",
          "Verification": "Verification",
          "Enter the OTP that is  sent to your phone number":
              "Enter the OTP that is  sent to your phone number",
          "pin": "pin",
          "Confirm pin": "Confirm pin",
          "please Enter OTP": "please Enter OTP",
          "Submit": "Submit",

          //Home page
          "Send a Report": "Send a Report",
          "You can add multi media files into one report":
              "You can add multi media files into one report",
          "Photo": "Photo",
          "Video": "Video",
          "Audio": "Audio",
          "Link": "Link",
          "File": "File",

          "Announcements": "Announcements",
          "News": "News",
          "Road Closure": "Road Closure",
          "Wanted Persons": "Wanted Persons",
          "Missing Persons or Item": "Missing Persons or Item",
          "Read More": "Read More",

          "People of Determination": "People of Determination",
          "Request a \n  Direct  Call": "Request a \n  Direct  Call",
          "Record Sign \n  Language Video": "Record Sign \n  Language Video",

          "Please attach at least one audio, image, link, or video.":
              "Please attach at least one audio, image, link, or video.",
          "Please select Date and Time.": "Please select Date and Time.",
          "Failed to send report. Please try again later.":
              "Failed to send report. Please try again later.",
          "Report Sent": "Report Sent",
          "Unexpected response from the server.":
              "Unexpected response from the server.",
          "The request timed out. Please try again.":
              "The request timed out. Please try again.",
          "An unexpected error occurred. Please try again later.":
              "An unexpected error occurred. Please try again later.",

          //Road Closure page
          "City": "City",
          "From": "From",
          "To": "To",
          "From Date and time": "From Date and time",
          "To Date and time": "To Date and time",
          "Remark": "Remark",
          "View": "View",

          //Wanted Persons page

          "Gender": "Gender",
          "Wanted": "Wanted",
          "Retry": "Retry",
          "Please Check Your Internet Connection and Try Again":
              "Please Check Your Internet Connection and Try Again",
          "Network Error": "Network Error",
          "Full name": "Full name",
          "Age": "Age",
          "Dangerous": "Dangerous",

          //Missing Persons or Item page

          "Missing Persons": "Missing Persons",
          "Missing": "Missing",
          "Contact Phone number": "Contact Phone number",
          "Contact Email": "Contact Email",

          // TabView
          "Reports": "Reports",
          "No internet connection": "No internet connection",

          "Incident Time": "Incident Time",
          "Select Incident Time": "Select Incident Time",
          "No date and time selected": "No date and time selected",
          "Selected date and time:": "Selected date and time:",
          "Contact me for clarification": "Contact me for clarification",

          //SendPhoto
          "Invalid File!!": "Invalid File!!",
          "Please select an image.": "Please select an image.",
          "Please select a non-empty image file less than 20 MB":
              "Please select a non-empty image file less than 20 MB",
          "You can upload 5 Photo files": "You can upload 5 Photo files",
          "Photo Upload": "Photo Upload",

          "Take Photo": "Take Photo",
          "Gallery": "Gallery",
          "Upload Photos": "Upload Photos",
          "Close": "Close",

          "Maximum upload size: 20 MB.": "Maximum upload size: 20 MB.",

          //send video
          "Please select a Video.": "Please select a Video.",
          "Please select a non-empty Video file less than 50 MB":
              "Please select a non-empty Video file less than 50 MB",

          "Video Upload": "Video Upload",

          "Take Video": "Take Video",
          "Maximum upload size: 50 MB.": "Maximum upload size: 50 MB.",
          "Upload Video": "Upload Video",
          "You can upload 5 Video files": "You can upload 5 Video files",

          //Send Audio
          "You can upload 5 audio files": "You can upload 5 audio files",
          "Audio Upload": "Audio Upload",
          "Start Recording": "Start Recording ",
          "Stop Recording": "Stop Recording",
          "Pick from File": "Pick from File",
          "Please select an audio file.": "Please select an audio file.",

          "Please record an audio file.": "Please record an audio file.",
          "Please record a non-empty audio file less than 5 MB.":
              "Please record a non-empty audio file less than 5 MB.",

          "Please select a non-empty audio file less than 5 MB.":
              "Please select a non-empty audio file less than 5 MB.",
          "Upload Audio": "Upload Audio",
          "You can upload 5 Audio files": "You can upload 5 Audio files",
          "Maximum upload size: 5 MB.": "Maximum upload size: 5 MB.",
          "By cliking start record  you can automatically start recording":
              "By cliking start record  you can automatically start recording",

          //send link
          "You can upload 5 Links": "You can upload 5 Links",
          "Add link": "Add link",
          "Enter URL": "Enter URL",

          "Type URLL": "Type URL",
          "Cancel": "Cancel",

          "Link Upload": "Link Upload",

          "Invalid URL": "Invalid URL",

          //Send File page
          "File Upload": "File Upload",
          "Upload Files": "Upload Files",
          "You can upload 5  files": "You can upload 5  files",

          "Insert File": "Insert File",
          "File Too Large!!": "File Too Large!!",
          "Please select a file smaller than 20 MB":
              "Please select a file smaller than 20 MB",
          "Please select a PDF or DOC file": "Please select a PDF or DOC file",

          // Main Page
          "Press back again to exit": "Press back again to exit",
          "Home": "Home",

          "Setting": "Setting",

          // Report page
          "You have no report.": "You have no report.",
          "Start protecting your society by reporting it to us through photo, video, or audio.":
              "Start protecting your society by reporting it to us through photo, video, or audio.",
          "hour": "hour",
          "Rating sent": "Rating sent",
          "Rating not sent": "Rating not sent",
          "Assigned": "Assigned",
          "Closed": "Closed",
          "Deferred": "Deferred",
          "In Progress": "In Progress",
          "Not Assigned": "Not Assigned",
          "Referred": "Referred",
          "Unknown": "Unknown",

          //Ticket Details
          "Ticket Details": "Ticket Details",
          "hours ago": "hours ago",
          "We sincerely appreciate your report":
              "We sincerely appreciate your report",
          "Description": "Description",
          "Kindly rate your experience": "Kindly rate your experience",
          "Rate": "Rate",
          "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our ":
              "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our",
          " page. Thank you.": "page. Thank you.",
          "Uploaded Videos": "Uploaded Videos",
          "Uploaded Links": "Uploaded Links",
          "Uploaded Photos": "Uploaded Photos",
          "Uploaded Audios": "Uploaded Audios",
          "Happy": "Happy",
          "Good": "Good",
          "Fair": "Fair",
          "Sad": "Sad",

          //Setting page

          "Language": "Language",
          "Change Language": "Change Language",
          "Account": "Account",
          "Manage your Account": "Manage your Account",
          "About us": "About us",
          "Learn more about us": "Learn more about us",
          "Contact us": "Contact us",
          "Get in touch with us": "Get in touch with us",
          "Terms and Conditions": "Terms and Conditions",
          "Read the terms and conditions": "Read the terms and conditions",
          "Privacy Policy": "Privacy Policy",
          "View our privacy policy": "View our privacy policy",
          "Rate us": "Rate us",
          "Leave a rating and review": "Leave a rating and review",
          "Logout": "Logout",
          "Sign out of your account": "Sign out of your account",

          //lanaguage
          "Languages": "Languages",
          "Select your preferred language": "Select your preferred language",
          "Set Language": "Set Language",
          "Amharic": "Amharic",
          "English": "English",
          "Affan Oromo": "Affan Oromo",
          "Tigirigna": "Tigirigna",
          "Somali": "Somali",

          //Account
          "Account Status": "Account Status",
          "Profile": "Profile",
          "Change Pin": "Change Pin",
          "Remove Acccount": "Remove Acccount",

          //Chanage pin

          "Please enter your old Pin and a new Pin":
              "Please enter your old Pin and a new Pin",
          "Old Pin": "Old Pin",
          "New Pin": "New Pin",
          "Confirm new Pin": "Confirm new Pin",
          "Update Pin": "Update Pin",
          "pin updated": "pin updated",
          "pin not updated please check your old pin":
              "pin not updated please check your old pin",
          "pin Don't Match": "pin Don't Match",

          //remove account
          "Remove Account": "Remove Account",
          "Select the reason for deleting their account":
              "Select the reason for deleting their account",

          "Write your reason": "Write your reason",
          "No longer needed": "No longer needed",
          "Privacy concern": "Privacy concern",
          "Account security concerns": "Account security concerns",
          "Too many notifications": "Too many notifications",
          "Difficulty using the app": "Difficulty using the app",
          "Other": "Other",

          //About us
          "Address": "Address",
          "Call Us": "Call Us",
          "Email Us": "Email Us",
          "FAQ": "FAQ",

          // Contact us
          "Contact Us": "Contact Us",
          "General Inquiry": "General Inquiry",
          "App Issue": "App Issue",
          "Know my ticket status": "Know my ticket status",
          "Grivenances": "Grivenances",

          "We are here to help": "We are here to help",

          "What can we help you with?": "What can we help you with?",
          "Select an option": "Select an option",
          "Tell us more about your problem": "Tell us more about your problem",

          //Logout
          "Log out": "Log out",
          "Are you sure you want to log out?":
              "Are you sure you want to log out?",

          //Profile
          "Update": "Update",

          //Notification
          "You have no notifications": "You have no notifications",
          "Notification": "Notification",
        },
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'so': {
          "ETPoliceApp": "Xogta Bulshada",

          // sign up
          //spalsh
          "Location Permission": "Location Permission",
          "We need location permission to assign your reports to the nearest police station.":
              "We need location permission to assign your reports to the nearest police station.",
          "OK": "OK",
          "ETPoliceApp 2024. All rights reserved":
              "ETPoliceApp 2024. All rights reserved",

          // sign up
          "Create an account": "Create an account",
          "Thank you for making our society safer.":
              "Thank you for making our society safer.",
          "Phone 9******": "Phone 9******",
          "Pin": "Pin",

          "Already Have an Account ?": "Already Have an Account ?",
          "I accept the terms and conditions":
              "I accept the terms and conditions",

          "Please Provide valid Phone Number!":
              "Please Provide valid Phone Number!",

          "Please enter a pin": "Please enter a pin",
          "Pin must be exactly 6 digits long":
              "Pin must be exactly 6 digits long",
          "Pin must contain only numeric digits":
              "Pin must contain only numeric digits",
          "Error": "Error",
          "Please check the terms and conditions":
              "Please check the terms and conditions",
          "Success": "Success",
          "You have successfully registered":
              "You have successfully registered",

          "Phone number has already been taken":
              "Phone number has already been taken",
          "failed, try again later": "failed, try again later",
          "Invalid OTP": "Invalid OTP",
          "Something went wrong": "Something went wrong",
          "OTP resent": "OTP resent",

          //sign in
          "Welcome Back": "Welcome Back",

          "Log In": "Log In",

          "Forgot your pin ?": "Forgot your pin ?",
          "Don't have an account?": "Don't have an account?",
          "Sign up": "Sign up",

          "Please enter pin": "Please enter pin",
          "The provided credentials are incorrect.":
              "The provided credentials are incorrect.",
          "Your phone number is not verified":
              "Your phone number is not verified",

          //Forgot pin
          "Forgot pin": "Forgot pin",
          "Please enter your Phone number": "Please enter your Phone number",
          "You will receive a code to create a new pin.":
              "You will receive a code to create a new pin.",
          "Please, input you phone number": "Please, input you phone number",
          "Send": "Send",
          "We have sent Otp": "We have sent Otp",
          "An error occurred, try again later":
              "An error occurred, try again later",
          "Password Reset": "Password Reset",
          "Password Don't Match": "Password Don't Match",
          "Verification": "Verification",
          "Enter the OTP that is  sent to your phone number":
              "Enter the OTP that is  sent to your phone number",
          "pin": "pin",
          "Confirm pin": "Confirm pin",
          "please Enter OTP": "please Enter OTP",
          "Submit": "Submit",

          //Home page
          "Send a Report": "Send a Report",
          "You can add multi media files into one report":
              "You can add multi media files into one report",
          "Photo": "Photo",
          "Video": "Video",
          "Audio": "Audio",
          "Link": "Link",
          "File": "File",

          "Announcements": "Announcements",
          "News": "News",
          "Road Closure": "Road Closure",
          "Wanted Persons": "Wanted Persons",
          "Missing Persons or Item": "Missing Persons or Item",
          "Read More": "Read More",

          "People of Determination": "People of Determination",
          "Request a \n  Direct  Call": "Request a \n  Direct  Call",
          "Record Sign \n  Language Video": "Record Sign \n  Language Video",

          "Please attach at least one audio, image, link, or video.":
              "Please attach at least one audio, image, link, or video.",
          "Please select Date and Time.": "Please select Date and Time.",
          "Failed to send report. Please try again later.":
              "Failed to send report. Please try again later.",
          "Report Sent": "Report Sent",
          "Unexpected response from the server.":
              "Unexpected response from the server.",
          "The request timed out. Please try again.":
              "The request timed out. Please try again.",
          "An unexpected error occurred. Please try again later.":
              "An unexpected error occurred. Please try again later.",

          //Road Closure page
          "City": "City",
          "From": "From",
          "To": "To",
          "From Date and time": "From Date and time",
          "To Date and time": "To Date and time",
          "Remark": "Remark",
          "View": "View",

          //Wanted Persons page

          "Gender": "Gender",
          "Wanted": "Wanted",
          "Retry": "Retry",
          "Please Check Your Internet Connection and Try Again":
              "Please Check Your Internet Connection and Try Again",
          "Network Error": "Network Error",
          "Full name": "Full name",
          "Age": "Age",
          "Dangerous": "Dangerous",

          //Missing Persons or Item page

          "Missing Persons": "Missing Persons",
          "Missing": "Missing",
          "Contact Phone number": "Contact Phone number",
          "Contact Email": "Contact Email",

          // TabView
          "Reports": "Reports",
          "No internet connection": "No internet connection",

          "Incident Time": "Incident Time",
          "Select Incident Time": "Select Incident Time",
          "No date and time selected": "No date and time selected",
          "Selected date and time:": "Selected date and time:",
          "Contact me for clarification": "Contact me for clarification",

          //SendPhoto
          "Invalid File!!": "Invalid File!!",
          "Please select an image.": "Please select an image.",
          "Please select a non-empty image file less than 20 MB":
              "Please select a non-empty image file less than 20 MB",
          "You can upload 5 Photo files": "You can upload 5 Photo files",
          "Photo Upload": "Photo Upload",

          "Take Photo": "Take Photo",
          "Gallery": "Gallery",
          "Upload Photos": "Upload Photos",
          "Close": "Close",

          "Maximum upload size: 20 MB.": "Maximum upload size: 20 MB.",

          //send video
          "Please select a Video.": "Please select a Video.",
          "Please select a non-empty Video file less than 50 MB":
              "Please select a non-empty Video file less than 50 MB",

          "Video Upload": "Video Upload",

          "Take Video": "Take Video",
          "Maximum upload size: 50 MB.": "Maximum upload size: 50 MB.",
          "Upload Video": "Upload Video",
          "You can upload 5 Video files": "You can upload 5 Video files",

          //Send Audio
          "You can upload 5 audio files": "You can upload 5 audio files",
          "Audio Upload": "Audio Upload",
          "Start Recording": "Start Recording ",
          "Stop Recording": "Stop Recording",
          "Pick from File": "Pick from File",
          "Please select an audio file.": "Please select an audio file.",

          "Please record an audio file.": "Please record an audio file.",
          "Please record a non-empty audio file less than 5 MB.":
              "Please record a non-empty audio file less than 5 MB.",

          "Please select a non-empty audio file less than 5 MB.":
              "Please select a non-empty audio file less than 5 MB.",
          "Upload Audio": "Upload Audio",
          "You can upload 5 Audio files": "You can upload 5 Audio files",
          "Maximum upload size: 5 MB.": "Maximum upload size: 5 MB.",
          "By cliking start record  you can automatically start recording":
              "By cliking start record  you can automatically start recording",

          //send link
          "You can upload 5 Links": "You can upload 5 Links",
          "Add link": "Add link",
          "Enter URL": "Enter URL",

          "Type URLL": "Type URL",
          "Cancel": "Cancel",

          "Link Upload": "Link Upload",

          "Invalid URL": "Invalid URL",

          //Send File page
          "File Upload": "File Upload",
          "Upload Files": "Upload Files",
          "You can upload 5  files": "You can upload 5  files",

          "Insert File": "Insert File",
          "File Too Large!!": "File Too Large!!",
          "Please select a file smaller than 20 MB":
              "Please select a file smaller than 20 MB",
          "Please select a PDF or DOC file": "Please select a PDF or DOC file",

          // Main Page
          "Press back again to exit": "Press back again to exit",
          "Home": "Home",

          "Setting": "Setting",

          // Report page
          "You have no report.": "You have no report.",
          "Start protecting your society by reporting it to us through photo, video, or audio.":
              "Start protecting your society by reporting it to us through photo, video, or audio.",
          "hour": "hour",
          "Rating sent": "Rating sent",
          "Rating not sent": "Rating not sent",
          "Assigned": "Assigned",
          "Closed": "Closed",
          "Deferred": "Deferred",
          "In Progress": "In Progress",
          "Not Assigned": "Not Assigned",
          "Referred": "Referred",
          "Unknown": "Unknown",

          //Ticket Details
          "Ticket Details": "Ticket Details",
          "hours ago": "hours ago",
          "We sincerely appreciate your report":
              "We sincerely appreciate your report",
          "Description": "Description",
          "Kindly rate your experience": "Kindly rate your experience",
          "Rate": "Rate",
          "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our ":
              "We are sorry that you had a bad experience using our application. Would you like to describe the issue to us through our",
          " page. Thank you.": "page. Thank you.",
          "Uploaded Videos": "Uploaded Videos",
          "Uploaded Links": "Uploaded Links",
          "Uploaded Photos": "Uploaded Photos",
          "Uploaded Audios": "Uploaded Audios",
          "Happy": "Happy",
          "Good": "Good",
          "Fair": "Fair",
          "Sad": "Sad",

          //Setting page

          "Language": "Language",
          "Change Language": "Change Language",
          "Account": "Account",
          "Manage your Account": "Manage your Account",
          "About us": "About us",
          "Learn more about us": "Learn more about us",
          "Contact us": "Contact us",
          "Get in touch with us": "Get in touch with us",
          "Terms and Conditions": "Terms and Conditions",
          "Read the terms and conditions": "Read the terms and conditions",
          "Privacy Policy": "Privacy Policy",
          "View our privacy policy": "View our privacy policy",
          "Rate us": "Rate us",
          "Leave a rating and review": "Leave a rating and review",
          "Logout": "Logout",
          "Sign out of your account": "Sign out of your account",

          //lanaguage
          "Languages": "Languages",
          "Select your preferred language": "Select your preferred language",
          "Set Language": "Set Language",
          "Amharic": "Amharic",
          "English": "English",
          "Affan Oromo": "Affan Oromo",
          "Tigirigna": "Tigirigna",
          "Somali": "Somali",

          //Account
          "Account Status": "Account Status",
          "Profile": "Profile",
          "Change Pin": "Change Pin",
          "Remove Acccount": "Remove Acccount",

          //Chanage pin

          "Please enter your old Pin and a new Pin":
              "Please enter your old Pin and a new Pin",
          "Old Pin": "Old Pin",
          "New Pin": "New Pin",
          "Confirm new Pin": "Confirm new Pin",
          "Update Pin": "Update Pin",
          "pin updated": "pin updated",
          "pin not updated please check your old pin":
              "pin not updated please check your old pin",
          "pin Don't Match": "pin Don't Match",

          //remove account
          "Remove Account": "Remove Account",
          "Select the reason for deleting their account":
              "Select the reason for deleting their account",

          "Write your reason": "Write your reason",
          "No longer needed": "No longer needed",
          "Privacy concern": "Privacy concern",
          "Account security concerns": "Account security concerns",
          "Too many notifications": "Too many notifications",
          "Difficulty using the app": "Difficulty using the app",
          "Other": "Other",

          //About us
          "Address": "Address",
          "Call Us": "Call Us",
          "Email Us": "Email Us",
          "FAQ": "FAQ",

          // Contact us
          "Contact Us": "Contact Us",
          "General Inquiry": "General Inquiry",
          "App Issue": "App Issue",
          "Know my ticket status": "Know my ticket status",
          "Grivenances": "Grivenances",

          "We are here to help": "We are here to help",

          "What can we help you with?": "What can we help you with?",
          "Select an option": "Select an option",
          "Tell us more about your problem": "Tell us more about your problem",

          //Logout
          "Log out": "Log out",
          "Are you sure you want to log out?":
              "Are you sure you want to log out?",

          //Profile
          "Update": "Update",

          //Notification
          "You have no notifications": "You have no notifications",
          "Notification": "Notification",
        }
      };
}
