package com.fabriciodevbranch.paperhangman.data;

import com.fabriciodevbranch.paperhangman.model.Category;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class WordRepository {

    private static final Map<String, List<String>> WORDS = new HashMap<>();

    static {
        WORDS.put("animals", Arrays.asList(
                "capybara", "butterfly", "otter", "penguin",
                "jaguar", "rabbit", "koala", "turtle"));
        WORDS.put("countries", Arrays.asList(
                "brazil", "canada", "japan", "mexico",
                "norway", "india", "italy", "angola"));
        WORDS.put("tech", Arrays.asList(
                "android", "laptop", "router", "keyboard",
                "widget", "server", "binary", "docker"));
        WORDS.put("brazilian_words", Arrays.asList(
                "açaí", "coração", "paçoca", "limão",
                "pão", "avião", "maçã", "café"));
    }

    private final Random random;

    public WordRepository() {
        this.random = new Random();
    }

    public String randomWordFor(Category category) {
        List<String> words;
        if (category == Category.RANDOM) {
            words = new ArrayList<>();
            for (Category c : Category.SELECTABLE_VALUES) {
                List<String> list = WORDS.get(c.id);
                if (list != null) {
                    words.addAll(list);
                }
            }
        } else {
            List<String> list = WORDS.get(category.id);
            words = list != null ? list : new ArrayList<>();
        }

        if (words.isEmpty()) {
            throw new IllegalStateException("No words available for category: " + category.id);
        }
        return words.get(random.nextInt(words.size()));
    }
}
