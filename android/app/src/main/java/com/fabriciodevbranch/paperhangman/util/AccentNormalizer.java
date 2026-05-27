package com.fabriciodevbranch.paperhangman.util;

import java.util.HashMap;
import java.util.Map;

public class AccentNormalizer {

    private static final Map<Character, Character> REPLACEMENTS = new HashMap<>();

    static {
        REPLACEMENTS.put('Á', 'A'); REPLACEMENTS.put('À', 'A');
        REPLACEMENTS.put('Ã', 'A'); REPLACEMENTS.put('Â', 'A'); REPLACEMENTS.put('Ä', 'A');
        REPLACEMENTS.put('É', 'E'); REPLACEMENTS.put('È', 'E');
        REPLACEMENTS.put('Ê', 'E'); REPLACEMENTS.put('Ë', 'E');
        REPLACEMENTS.put('Í', 'I'); REPLACEMENTS.put('Ì', 'I');
        REPLACEMENTS.put('Î', 'I'); REPLACEMENTS.put('Ï', 'I');
        REPLACEMENTS.put('Ó', 'O'); REPLACEMENTS.put('Ò', 'O');
        REPLACEMENTS.put('Õ', 'O'); REPLACEMENTS.put('Ô', 'O'); REPLACEMENTS.put('Ö', 'O');
        REPLACEMENTS.put('Ú', 'U'); REPLACEMENTS.put('Ù', 'U');
        REPLACEMENTS.put('Û', 'U'); REPLACEMENTS.put('Ü', 'U');
        REPLACEMENTS.put('Ç', 'C');
    }

    public static String normalize(String value) {
        String upper = value.toUpperCase();
        StringBuilder sb = new StringBuilder(upper.length());
        for (char c : upper.toCharArray()) {
            Character replacement = REPLACEMENTS.get(c);
            sb.append(replacement != null ? replacement : c);
        }
        return sb.toString();
    }

    public static boolean isGuessableLetter(char character) {
        String normalized = normalize(String.valueOf(character));
        return normalized.length() == 1
                && normalized.charAt(0) >= 'A'
                && normalized.charAt(0) <= 'Z';
    }
}
