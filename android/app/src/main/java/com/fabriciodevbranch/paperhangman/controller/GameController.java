package com.fabriciodevbranch.paperhangman.controller;

import com.fabriciodevbranch.paperhangman.data.WordRepository;
import com.fabriciodevbranch.paperhangman.model.Category;
import com.fabriciodevbranch.paperhangman.model.GameSession;
import com.fabriciodevbranch.paperhangman.model.GameStatus;
import com.fabriciodevbranch.paperhangman.util.AccentNormalizer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class GameController {

    public interface GameListener {
        void onGameStateChanged();
    }

    private static GameController instance;

    public static GameController getInstance() {
        if (instance == null) {
            instance = new GameController();
        }
        return instance;
    }

    private final WordRepository wordRepository = new WordRepository();
    private final List<GameListener> listeners = new ArrayList<>();

    private Category selectedCategory = Category.RANDOM;
    private boolean soundEnabled = true;
    private boolean nightModeEnabled = false;
    private GameSession session;

    private GameController() {}

    public void addListener(GameListener listener) {
        if (!listeners.contains(listener)) {
            listeners.add(listener);
        }
    }

    public void removeListener(GameListener listener) {
        listeners.remove(listener);
    }

    private void notifyListeners() {
        for (GameListener l : new ArrayList<>(listeners)) {
            l.onGameStateChanged();
        }
    }

    // — Getters —

    public Category getSelectedCategory() {
        return selectedCategory;
    }

    public boolean isSoundEnabled() {
        return soundEnabled;
    }

    public boolean isNightModeEnabled() {
        return nightModeEnabled;
    }

    public GameSession getSession() {
        return session;
    }

    // — Actions —

    public void selectCategory(Category category) {
        selectedCategory = category;
        notifyListeners();
    }

    public void updateSoundEnabled(boolean value) {
        soundEnabled = value;
        notifyListeners();
    }

    public void updateNightMode(boolean value) {
        nightModeEnabled = value;
        notifyListeners();
    }

    public void startGame() {
        startGame(null);
    }

    public void startGame(Category category) {
        if (category != null) {
            selectedCategory = category;
        }
        String word = wordRepository.randomWordFor(selectedCategory);
        session = GameSession.initial(
                word.toUpperCase(),
                AccentNormalizer.normalize(word),
                selectedCategory);
        notifyListeners();
    }

    public void guessLetter(String letter) {
        if (session == null || session.status != GameStatus.PLAYING) {
            return;
        }
        String normalizedLetter = AccentNormalizer.normalize(letter);
        if (!normalizedLetter.matches("[A-Z]") || session.guessedLetters.contains(normalizedLetter)) {
            return;
        }

        Set<String> guessedLetters = new HashSet<>(session.guessedLetters);
        guessedLetters.add(normalizedLetter);

        boolean wasCorrect = session.normalizedWord.contains(normalizedLetter);
        Set<String> wrongLetters = new HashSet<>(session.wrongLetters);
        int remainingAttempts = session.remainingAttempts;

        if (!wasCorrect) {
            wrongLetters.add(normalizedLetter);
            remainingAttempts--;
        }

        GameStatus nextStatus;
        if (didRevealEveryLetter(session.originalWord, guessedLetters)) {
            nextStatus = GameStatus.WON;
        } else if (remainingAttempts <= 0) {
            nextStatus = GameStatus.LOST;
        } else {
            nextStatus = GameStatus.PLAYING;
        }

        session = session.withGuess(guessedLetters, wrongLetters, remainingAttempts, nextStatus);
        notifyListeners();
    }

    public void resetSession() {
        session = null;
        notifyListeners();
    }

    public boolean isLetterGuessed(String letter) {
        if (session == null) {
            return false;
        }
        return session.guessedLetters.contains(AccentNormalizer.normalize(letter));
    }

    public List<String> getVisibleCharacters() {
        if (session == null) {
            return Collections.emptyList();
        }
        List<String> result = new ArrayList<>();
        for (char c : session.originalWord.toCharArray()) {
            if (!AccentNormalizer.isGuessableLetter(c)) {
                result.add(String.valueOf(c));
            } else {
                String normalized = AccentNormalizer.normalize(String.valueOf(c));
                result.add(session.guessedLetters.contains(normalized) ? String.valueOf(c) : "_");
            }
        }
        return result;
    }

    public List<String> getWrongLettersSorted() {
        if (session == null) {
            return Collections.emptyList();
        }
        List<String> list = new ArrayList<>(session.wrongLetters);
        Collections.sort(list);
        return list;
    }

    public List<String> getGuessedLettersSorted() {
        if (session == null) {
            return Collections.emptyList();
        }
        List<String> list = new ArrayList<>(session.guessedLetters);
        Collections.sort(list);
        return list;
    }

    private boolean didRevealEveryLetter(String word, Set<String> guessedLetters) {
        for (char c : word.toCharArray()) {
            if (AccentNormalizer.isGuessableLetter(c)) {
                String normalized = AccentNormalizer.normalize(String.valueOf(c));
                if (!guessedLetters.contains(normalized)) {
                    return false;
                }
            }
        }
        return true;
    }
}
