package com.fabriciodevbranch.paperhangman.model;

import java.util.Arrays;
import java.util.List;

public class Category {
    public final String id;
    public final String title;

    private Category(String id, String title) {
        this.id = id;
        this.title = title;
    }

    public static final Category ANIMALS = new Category("animals", "Animals");
    public static final Category COUNTRIES = new Category("countries", "Countries");
    public static final Category TECH = new Category("tech", "Tech");
    public static final Category BRAZILIAN_WORDS = new Category("brazilian_words", "Brazilian Words");
    public static final Category RANDOM = new Category("random", "Random");

    public static final List<Category> VALUES = Arrays.asList(ANIMALS, COUNTRIES, TECH, BRAZILIAN_WORDS, RANDOM);
    public static final List<Category> SELECTABLE_VALUES = Arrays.asList(ANIMALS, COUNTRIES, TECH, BRAZILIAN_WORDS);

    @Override
    public String toString() {
        return title;
    }
}
