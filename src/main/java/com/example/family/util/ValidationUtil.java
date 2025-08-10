package com.example.family.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern ALPHABETIC = Pattern.compile("^[a-zA-Z]+$");
    private static final Pattern NUMERIC = Pattern.compile("^\\d+$");
    private static final Pattern PASSWORD_PATTERN =
            Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$");

    public static boolean isNullOrZero(Long value) {
        return value == null || value == 0;
    }


    // Check if string is null or empty
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    // Check if string is alphabetic
    public static boolean isAlphabetic(String str) {
        return str != null && ALPHABETIC.matcher(str).matches();
    }

    // Check if string is numeric
    public static boolean isNumeric(String str) {
        return str != null && NUMERIC.matcher(str).matches();
    }

    // Check if string is a valid email
    public static boolean isValidEmail(String str) {
        return str != null && EMAIL.matcher(str).matches();
    }

    // Capitalize the first letter
    public static String capitalize(String str) {
        if (isNullOrEmpty(str)) return str;
        return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
    }

    // Remove all non-digit characters (e.g., for cleaning phone numbers)
    public static String cleanDigits(String str) {
        return str != null ? str.replaceAll("\\D+", "") : null;
    }

    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

}
