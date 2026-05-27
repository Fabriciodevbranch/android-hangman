package com.fabriciodevbranch.paperhangman;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.app.AppCompatDelegate;

import com.fabriciodevbranch.paperhangman.controller.GameController;
import com.google.android.material.switchmaterial.SwitchMaterial;

public class SettingsActivity extends AppCompatActivity implements GameController.GameListener {

    private GameController controller;
    private SwitchMaterial switchSound;
    private SwitchMaterial switchNightMode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);

        controller = GameController.getInstance();

        if (getSupportActionBar() != null) {
            getSupportActionBar().setTitle(getString(R.string.settings));
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }

        switchSound = findViewById(R.id.switchSound);
        switchNightMode = findViewById(R.id.switchNightMode);

        switchSound.setChecked(controller.isSoundEnabled());
        switchNightMode.setChecked(controller.isNightModeEnabled());

        switchSound.setOnCheckedChangeListener((btn, isChecked) ->
                controller.updateSoundEnabled(isChecked));

        switchNightMode.setOnCheckedChangeListener((btn, isChecked) -> {
            controller.updateNightMode(isChecked);
            AppCompatDelegate.setDefaultNightMode(
                    isChecked ? AppCompatDelegate.MODE_NIGHT_YES : AppCompatDelegate.MODE_NIGHT_NO);
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        controller.addListener(this);
    }

    @Override
    protected void onPause() {
        super.onPause();
        controller.removeListener(this);
    }

    @Override
    public boolean onSupportNavigateUp() {
        finish();
        return true;
    }

    @Override
    public void onGameStateChanged() {
        switchSound.setChecked(controller.isSoundEnabled());
        switchNightMode.setChecked(controller.isNightModeEnabled());
    }
}
