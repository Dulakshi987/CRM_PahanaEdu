package com.billsystem.utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailUtil {
    private static final Logger logger = Logger.getLogger(EmailUtil.class.getName());

    // Mailtrap SMTP Configuration
    private static final String SMTP_HOST = "sandbox.smtp.mailtrap.io";
    private static final String SMTP_PORT = "587";

    // Replace these with your actual Mailtrap credentials
    private static final String MAILTRAP_USERNAME = "86d3e089f929ec";
    private static final String MAILTRAP_PASSWORD = "0fa3d2a6e40738";
    private static final String FROM_EMAIL = "ae0433367@gmail.com";

    public static boolean sendEmail(String to, String subject, String content) {
        return sendEmail(to, subject, content, true);
    }

    public static boolean sendEmail(String to, String subject, String content, boolean isHtml) {
        try {
            // Validate input parameters
            if (to == null || to.trim().isEmpty()) {
                logger.log(Level.WARNING, "Recipient email is null or empty");
                return false;
            }

            if (subject == null || subject.trim().isEmpty()) {
                subject = "No Subject";
            }

            if (content == null || content.trim().isEmpty()) {
                content = "No content";
            }

            // Mailtrap SMTP configuration
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.connectiontimeout", "10000");
            props.put("mail.smtp.timeout", "10000");

            // Create session with Mailtrap authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(MAILTRAP_USERNAME, MAILTRAP_PASSWORD);
                }
            });

            // Enable debug mode for development
            session.setDebug(true);

            // Create and configure message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Bill System - Test"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);

            // Set content type
            if (isHtml) {
                message.setContent(content, "text/html; charset=utf-8");
            } else {
                message.setText(content);
            }

            // Send the message
            logger.log(Level.INFO, "Attempting to send email via Mailtrap to: " + to);
            Transport.send(message);
            logger.log(Level.INFO, "Email sent successfully via Mailtrap to: " + to);

            return true;

        } catch (MessagingException e) {
            logger.log(Level.SEVERE, "MessagingException while sending email via Mailtrap to " + to + ": " + e.getMessage(), e);
            System.err.println("Mailtrap Email Error: " + e.getMessage());
            e.printStackTrace();
            return false;

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Unexpected error while sending email via Mailtrap to " + to + ": " + e.getMessage(), e);
            System.err.println("Unexpected Mailtrap Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Method to test Mailtrap configuration
    public static boolean testEmailConfiguration() {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(MAILTRAP_USERNAME, MAILTRAP_PASSWORD);
                }
            });

            Transport transport = session.getTransport("smtp");
            transport.connect(SMTP_HOST, MAILTRAP_USERNAME, MAILTRAP_PASSWORD);
            transport.close();

            logger.log(Level.INFO, "Mailtrap configuration test successful");
            System.out.println("Mailtrap configuration test successful");
            return true;

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Mailtrap configuration test failed: " + e.getMessage(), e);
            System.err.println("Mailtrap configuration test failed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}