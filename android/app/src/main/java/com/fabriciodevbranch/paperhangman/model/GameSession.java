package com.fabriciodevbranch.paperhangman.model;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class GameSession {
    public final String originalWord;
    public final String normalizedWord;
    public final Category category;
    public final Set<String> guessedLetters;
    public final Set<String> wrongLetters;
    public final int maxAttempts;
    public final int remainingAttempts;
    public final GameStatus status;

    public GameSession(
            String originalWord,
            String normalizedWord,
            Category category,
            Set<String> guessedLetters,
            Set<String> wrongLetters,
            int maxAttempts,
            int remainingAttempts,
            GameStatus status) {
        this.originalWord = originalWord;
        this.normalizedWord = normalizedWord;
        this.category = category;
        this.guessedLetters = Collections.unmodifiableSet(new HashSet<>(guessedLetters));
        this.wrongLetters = Collections.unmodifiableSet(new HashSet<>(wrongLetters));
        this.maxAttempts = maxAttempts;
        this.remainingAttempts = remainingAttempts;
        this.status = status;
    }

    public static GameSession initial(String originalWord, String normalizedWord, Category category) {
        return new GameSession(
                originalWord, normalizedWord, category,
                new HashSet<>(), new HashSet<>(),
                6, 6, GameStatus.PLAYING);
    }

    public int getWrongAttempts() {
        return maxAttempts - remainingAttempts;
    }

    public GameSession withGuess(
            Set<String> guessedLetters,
            Set<String> wrongLetters,
            int remainingAttempts,
            GameStatus status) {
        return new GameSession(
                originalWord, normalizedWord, category,
                guessedLetters, wrongLetters,
                maxAttempts, remainingAttempts, status);
    }
}
