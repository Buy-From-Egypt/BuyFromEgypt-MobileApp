import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static Future<void> sendOtpEmail(
      String recipientEmail, String otp, String subject) async {
    final smtpServer = SmtpServer('smtp.gmail.com',
        username: 'buyfromegypt@gmail.com',
        port: 587,
        ssl: false,
        allowInsecure: true);

    String emailBody;
    if (subject.contains('password')) {
      emailBody = '''Dear User,

We received a request to reset your password for your Buy From Egypt account.

Your verification code is: $otp

This code will expire in 5 minutes.
Please enter this code in the verification screen to complete your password reset.

If you did not request this code, please ignore this email or contact support if you believe this is suspicious activity.

Best regards,
Buy From Egypt Team''';
    } else {
      emailBody = '''Dear User,

Welcome to Buy From Egypt!

Your verification code is: $otp

This code will expire in 5 minutes.
Please enter this code in the verification screen to complete your registration.

For security reasons, we recommend setting a strong password for your account.

If you did not request this code, please ignore this email.

Best regards,
Buy From Egypt Team''';
    }

    final message = Message()
      ..from = Address('buyfromegypt@gmail.com', 'Buy From Egypt')
      ..recipients.add(recipientEmail)
      ..subject = subject
      ..text = emailBody;

    try {
      await send(message, smtpServer);
    } catch (error) {
      print('Error sending email: $error');
      throw Exception('Failed to send email: ${error.toString()}');
    }
  }
}
