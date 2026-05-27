package com.fabriciodevbranch.paperhangman;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.app.AppCompatDelegate;

import com.fabriciodevbranch.paperhangman.controller.GameController;
import com.fabriciodevbranch.paperhangman.model.Category;
import com.google.android.material.button.MaterialButton;

public class MainActivity extends AppCompatActivity implements GameController.GameListener {

    private GameController controller;
    private TextView tvSelectedCategory;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        applyNightMode();
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        controller = GameController.getInstance();

        tvSelectedCategory = findViewById(R.id.tvSelectedCategory);

        MaterialButton btnStartGame = findViewById(R.id.btnStartGame);
        MaterialButton btnChooseCategory = findViewById(R.id.btnChooseCategory);
        MaterialButton btnSettings = findViewById(R.id.btnSettings);

        btnStartGame.setOnClickListener(v -> {
            controller.startGame();
            startActivity(new Intent(this, GameActivity.class));
        });

        btnChooseCategory.setOnClickListener(v ->
                startActivity(new Intent(this, CategoryActivity.class)));

        btnSettings.setOnClickListener(v ->
                startActivity(new Intent(this, SettingsActivity.class)));

        updateUI();
    }

    @Override
    protected void onResume() {
        super.onResume();
        controller.addListener(this);
        applyNightMode();
        updateUI();
    }

    @Override
    protected void onPause() {
        super.onPause();
        controller.removeListener(this);
    }

    @Override
    public void onGameStateChanged() {
        updateUI();
    }

    private void updateUI() {
        Category cat = controller.getSelectedCategory();
        if (cat == Category.RANDOM) {
            tvSelectedCategory.setText(getString(R.string.category_random_all));
        } else {
            tvSelectedCategory.setText(cat.title);
        }
    }

    private void applyNightMode() {
        boolean nightMode = GameController.getInstance().isNightModeEnabled();
        AppCompatDelegate.setDefaultNightMode(
                nightMode ? AppCompatDelegate.MODE_NIGHT_YES : AppCompatDelegate.MODE_NIGHT_NO);
    }
}

