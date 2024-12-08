// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';

import 'package:eventifyQr/services/CustomHttpClient.dart';
import 'package:eventifyQr/shared_Preference.dart';

// --------------------------- Get -------------------------------
var http = CustomHttpClient();
// Get Schools Data
String APIURL = "https://node-api-git-main-nikhil0667s-projects.vercel.app/api";
//String APIURL = "http://localhost:3000/api";

getSchools() async {
  var url = Uri.parse('${APIURL}/api/schools');
  var response = await http.get(url);

  return json.decode(response.body);
}

// ------------------------------ Post -------------------------
// ------------------------------ Admin Login ------------------------------
setAdminLogin(data) async {
  var url = Uri.parse('${APIURL}/admin/login');
  var response = await http.post(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;

  return {'body': responseBody, 'statusCode': statusCode};
}

setStudentLogin(data) async {
  var url = Uri.parse('${APIURL}/student/login');
  var response = await http.post(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;

  return {'body': responseBody, 'statusCode': statusCode};
}

setStudentRegister(data) async {
  print(data);
  var url = Uri.parse('${APIURL}/student');
  var response = await http.post(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;

  return {'body': responseBody, 'statusCode': statusCode};
}

// Studnet Login
getStudentLogin(data) async {
  var url = Uri.parse('${APIURL}/student/login');
  print(url);
  print(data);
  var response = await http.post(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;
  var token = await GetPreference('token').then((r) => r);

  //print("TOKEN :- $token ");
  return {'body': responseBody, 'statusCode': statusCode};
}

// ------------------------ Update(Put) -------------------------------
// Update review
setUpdateReview(data) async {
  //print(data);
  var url = Uri.parse('${APIURL}/review');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  var response = await http.put(url, body: jsonEncode(data), headers: headers);
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;
  // //print("RESPONSE BODY ${responseBody.toString()}");
  // //print("Status code ${statusCode.toString()}");

  // return {'body': responseBody, 'statusCode': statusCode};
}
// ------------------------ Delete -------------------------------

deleteCart(data) async {
  //print("$data");
  var url = Uri.parse('${APIURL}student/cart/$data');
  var response =
      await http.delete(url, headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;
  var token = await GetPreference('token').then((r) => r);

  return {'body': responseBody, 'statusCode': statusCode};
}

// Google Sign in
getGoogleSignIn(data) async {
  var url = Uri.parse('${APIURL}/student/google');
  var response = await http.post(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;
  var token = await GetPreference('token').then((r) => r);

  //print("TOKEN :- $token ");
  return {'body': responseBody, 'statusCode': statusCode};
}

// Buy the Course
buyNow(data) async {
  //print(data);
  var url = Uri.parse('${APIURL}/student/buy-course');
  var token = await GetPreference('token').then((r) => r);

  var response = await http.post(url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json', 'token': token});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;
  //print(responseBody.toString());
  return {'body': responseBody, 'statusCode': statusCode};
}

// Send Message
sendMessageApi(data, id) async {
  var url = Uri.parse('${APIURL}/student/send-message?id=${id}');
  var token = await GetPreference('token').then((r) => r);

  var response = await http.post(url, body: jsonEncode(data), headers: {
    'Content-Type': 'application/json',
    'token': token.toString(),
  });
  final responseBody = jsonDecode(response.body);

  return responseBody;
}

// Future<List<Datum>> getCourseListDisplay() async {
//   final url = Uri.parse('${APIURL}/pages/courses');
//   var token = await GetPreference('token').then((r) => r);
//   final headers = {
//     'token': token.toString(),
//     'Content-Type': 'application/json',
//   };

//   try {
//     final response = await http.get(url, headers: headers);
//     if (response.statusCode == 200) {
//       if (jsonDecode(response.body)['status'] == 200) {
//         final Map<String, dynamic> dataMap = json.decode(response.body);
//         final Schools schools = Schools.fromJson(dataMap);
//         return schools.data ?? [];
//       } else {
//         throw Exception(
//             'Invalid status: ${jsonDecode(response.body)['status']}');
//       }
//     } else {
//       // Handle specific HTTP status codes with error messages
//       if (response.statusCode == 401) {
//         throw Exception('Unauthorized: Invalid Token');
//       } else if (response.statusCode == 404) {
//         throw Exception('Not Found: The requested resource was not found');
//       } else {
//         throw Exception(
//             'Failed to load data. Status code: ${response.statusCode}');
//       }
//     }
//   } catch (e) {
//     // Handle network-related errors
//     throw Exception('Network Error: $e');
//   }
// }

getCourseListDisplay() async {
  final url = Uri.parse('${APIURL}/pages/courses');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getPackageDisplay() async {
  final url = Uri.parse('${APIURL}/pages/packages');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

// GET RECENT WATCH
getCourseRecent() async {
  final url = Uri.parse('${APIURL}pages/recent');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getMessages(id, sender) async {
  final url =
      Uri.parse('${APIURL}/student/chat-messages?id=${id}&sender=${sender}');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getMyCourse() async {
  final url = Uri.parse('${APIURL}pages/mycourses');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  //print(token);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getTeachers() async {
  final url = Uri.parse('${APIURL}/pages/myteachers');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getCourseDetail(id) async {
  //print("id ${id}");
  var url = Uri.parse('${APIURL}/pages/coursedetail/${id}');
  print(url);
  var token = await GetPreference('token').then((r) => r);
  // //print("TOKAN IN SERVICE ${token.toString()}");

  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)['status'] == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid status: ${jsonDecode(response.body)['status']}');
    }
  } else {
    // Handle specific HTTP status codes with error messages
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid Token');
    } else if (response.statusCode == 404) {
      throw Exception('Not Found: The requested resource was not found');
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}

// ChapterDetails
getChapterDetail({cid, cpid}) async {
  // //print("id ${chapter_id}");
  var url = Uri.parse('${APIURL}/pages/chapterdetail/${cid}/${cpid}');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  // //print("TOKAN IN SERVICE ${token.toString()}");
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)['status'] == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid status: ${jsonDecode(response.body)['status']}');
    }
  } else {
    // Handle specific HTTP status codes with error messages
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid Token');
    } else if (response.statusCode == 404) {
      throw Exception('Not Found: The requested resource was not found');
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}

getStudentMcqTest(q) async {
  final url = Uri.parse('${APIURL}mcq?${q}');
  print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        //print(jsonDecode(response.body)['data']);
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

setExmaStart(data, q) async {
  print("data ${data}");
  print("Q ${q}");
  var url = Uri.parse('${APIURL}/student/test?${q}');
  var token = await GetPreference('token').then((r) => r);
  print(url);
  var response = await http.post(url, body: jsonEncode(data), headers: {
    'Content-Type': 'application/json',
    'token': token.toString(),
  });
  final responseBody = jsonDecode(response.body);
  // ignore: unused_local_variable
  final statusCode = response.statusCode;

  return responseBody;
}

getMyexamData() async {
  final url = Uri.parse('${APIURL}/pages/myexams');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getResult(seid) async {
  // //print(seid);
  final url = Uri.parse('${APIURL}/pages/result/${seid}');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getnotification() async {
  final url = Uri.parse('${APIURL}/pages/notifications');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getanouncement() async {
  final url = Uri.parse('${APIURL}/pages/announcement');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

// NEW REVIEW CREATE

setReview(data) async {
  // //print(data);
  var url = Uri.parse('${APIURL}/review');

  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };
  var response = await http.post(url, body: jsonEncode(data), headers: headers);
  //print("response$response");
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;

  return {'body': responseBody, 'statusCode': statusCode};
}

setResendEmail(data) async {
  //print(data);
  var url = Uri.parse('${APIURL}/student/resend-email-verification');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };
  var response = await http.post(url, body: jsonEncode(data), headers: headers);
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;

  return {'body': responseBody, 'statusCode': statusCode};
}

getAssignment(caid) async {
  //print(caid);
  final url = Uri.parse('${APIURL}/pages/assigments/${caid}');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

getDount(cid) async {
  //print(caid);
  final url = Uri.parse('${APIURL}/doubt/my-doubts/${cid}');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

// Reset Exam
setMcqBankReset(q) async {
  //print('${APIURL}pages/resetbank?${q}');
  final url = Uri.parse('${APIURL}pages/resetbank?${q}');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    throw Exception('Network Error: $e');
  }
}

// GET RESULT ROUND
getResultRound(q) async {
  // print('${APIURL}pages/stud-rounds?${q}');

  final url = Uri.parse('${APIURL}pages/stud-rounds?${q}');
  print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    throw Exception('Network Error: $e');
  }
}

// GET RESULT BANK
getResultMcqbank(q) async {
  final url = Uri.parse('${APIURL}pages/stud-mcqbanks?${q}');
  print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    throw Exception('Network Error: $e');
  }
}

// Create and remove wishlist
getCourseWishlist({q}) async {
  //print("Query $q");
  //print('${APIURL}wishlist?${q}');
  final url = Uri.parse('${APIURL}wishlist?${q}');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    throw Exception('Network Error: $e');
  }
}

// Coupon Code
getCoupon({q}) async {
  //print('${APIURL}student/search-coupon?${q}');
  final url = Uri.parse('${APIURL}student/search-coupon?${q}');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        //print('Invalid status: ${jsonDecode(response.body)['status']}');
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    throw Exception('Network Error: $e');
  }
}

setAddCart(data) async {
  //print("$data");
  var url = Uri.parse('${APIURL}student/cart');
  var response = await http.post(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;
  var token = await GetPreference('token').then((r) => r);

  //print("TOKEN :- $token ");
  return {'body': responseBody, 'statusCode': statusCode};
}

getCartData() async {
  final url = Uri.parse('${APIURL}student/cart');
  //print(url);
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}

UpdatePlanCart({id, data}) async {
  //print("CART  DATA $data");
  //print("CART ID $id");
  var url = Uri.parse('${APIURL}student/cart/$id');
  var response = await http.put(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;
  var token = await GetPreference('token').then((r) => r);

  return {'body': responseBody, 'statusCode': statusCode};
}

//Search_Item
getSearchItem(q) async {
  // //print(q);
  final url = Uri.parse('${APIURL}pages/search?${q}');
  // //print(url);
  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        // //print("${response.body}");
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    throw Exception('Network Error: $e');
  }
}

// get Review
getReviewDetail(id) async {
  //print("id ${id}");
  var url = Uri.parse('${APIURL}/pages/review/${id}');
  var token = await GetPreference('token').then((r) => r);
  // //print("TOKAN IN SERVICE ${token.toString()}");
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)['status'] == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid status: ${jsonDecode(response.body)['status']}');
    }
  } else {
    // Handle specific HTTP status codes with error messages
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid Token');
    } else if (response.statusCode == 404) {
      throw Exception('Not Found: The requested resource was not found');
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}

//Query send
setQueryData(data) async {
  //print(data);
  var url = Uri.parse('${APIURL}query');
  var response = await http.post(url,
      body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  final responseBody = jsonDecode(response.body);
  final statusCode = response.statusCode;

  return {'body': responseBody, 'statusCode': statusCode};
}

getQueryData() async {
  final url = Uri.parse('${APIURL}query');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}
// Profile data

getProfileData() async {
  final url = Uri.parse('${APIURL}/student/profile');
  var token = await GetPreference('token').then((r) => r);
  final headers = {
    'token': token.toString(),
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Invalid status: ${jsonDecode(response.body)['status']}');
      }
    } else {
      // Handle specific HTTP status codes with error messages
      if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid Token');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found: The requested resource was not found');
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    // Handle network-related errors
    throw Exception('Network Error: $e');
  }
}
