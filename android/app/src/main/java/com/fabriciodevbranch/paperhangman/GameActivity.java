package com.fabriciodevbranch.paperhangman;

import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.Gravity;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.fabriciodevbranch.paperhangman.controller.GameController;
import com.fabriciodevbranch.paperhangman.model.GameSession;
import com.fabriciodevbranch.paperhangman.model.GameStatus;
import com.fabriciodevbranch.paperhangman.view.HangmanView;
import com.google.android.material.button.MaterialButton;
import com.google.android.material.card.MaterialCardView;

import java.util.List;

public class GameActivity extends AppCompatActivity implements GameController.GameListener {

    private GameController controller;
    private HangmanView hangmanView;
    private TextView tvWordDisplay;
    private TextView tvRemainingAttempts;
    private TextView tvWrongLetters;
    private TextView tvGuessedLetters;
    private LinearLayout keyboardContainer;

    private boolean dialogShown = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        controller = GameController.getInstance();

        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }

        hangmanView = findViewById(R.id.hangmanView);
        tvWordDisplay = findViewById(R.id.tvWordDisplay);
        tvRemainingAttempts = findViewById(R.id.tvRemainingAttempts);
        tvWrongLetters = findViewById(R.id.tvWrongLetters);
        tvGuessedLetters = findViewById(R.id.tvGuessedLetters);
        keyboardContainer = findViewById(R.id.keyboardContainer);

        buildKeyboard();
        updateUI();
    }

    @Override
    protected void onResume() {
        super.onResume();
        controller.addListener(this);
        updateUI();
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
        updateUI();
    }

    private void updateUI() {
        GameSession session = controller.getSession();
        if (session == null) {
            finish();
            return;
        }

        if (getSupportActionBar() != null) {
            getSupportActionBar().setTitle(session.category.title);
        }

        hangmanView.setStage(session.getWrongAttempts());

        // Word display
        List<String> visible = controller.getVisibleCharacters();
        StringBuilder wordSb = new StringBuilder();
        for (int i = 0; i < visible.size(); i++) {
            if (i > 0) wordSb.append("  ");
            wordSb.append(visible.get(i));
        }
        tvWordDisplay.setText(wordSb.toString());

        // Stats
        tvRemainingAttempts.setText(session.remainingAttempts + "/" + session.maxAttempts);

        List<String> wrong = controller.getWrongLettersSorted();
        tvWrongLetters.setText(wrong.isEmpty() ? "—" : String.join(" • ", wrong));

        List<String> guessed = controller.getGuessedLettersSorted();
        tvGuessedLetters.setText(guessed.isEmpty()
                ? getString(R.string.pick_first_letter)
                : String.join(" • ", guessed));

        // Update keyboard button states
        updateKeyboard();

        // Show result dialog if game ended
        if (session.status != GameStatus.PLAYING && !dialogShown) {
            dialogShown = true;
            showResultDialog(session);
        }
        if (session.status == GameStatus.PLAYING) {
            dialogShown = false;
        }
    }

    private void buildKeyboard() {
        String[] rows = {"QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"};
        int dpPadding = (int) (4 * getResources().getDisplayMetrics().density);
        int buttonSize = (int) (40 * getResources().getDisplayMetrics().density);

        for (String row : rows) {
            LinearLayout rowLayout = new LinearLayout(this);
            rowLayout.setOrientation(LinearLayout.HORIZONTAL);
            rowLayout.setGravity(Gravity.CENTER_HORIZONTAL);
            LinearLayout.LayoutParams rowParams = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT);
            rowParams.setMargins(0, dpPadding, 0, dpPadding);
            rowLayout.setLayoutParams(rowParams);

            for (char c : row.toCharArray()) {
                MaterialButton btn = new MaterialButton(this,
                        null, com.google.android.material.R.attr.materialButtonOutlinedStyle);
                btn.setText(String.valueOf(c));
                btn.setTag(String.valueOf(c));
                btn.setPadding(0, 0, 0, 0);
                btn.setInsetTop(0);
                btn.setInsetBottom(0);
                btn.setMinWidth(buttonSize);
                btn.setMinimumWidth(buttonSize);
                btn.setMinHeight(buttonSize);
                btn.setMinimumHeight(buttonSize);
                LinearLayout.LayoutParams btnParams = new LinearLayout.LayoutParams(
                        buttonSize, buttonSize);
                btnParams.setMargins(dpPadding, 0, dpPadding, 0);
                btn.setLayoutParams(btnParams);
                btn.setOnClickListener(v -> controller.guessLetter((String) v.getTag()));
                rowLayout.addView(btn);
            }
            keyboardContainer.addView(rowLayout);
        }
    }

    private void updateKeyboard() {
        for (int i = 0; i < keyboardContainer.getChildCount(); i++) {
            LinearLayout row = (LinearLayout) keyboardContainer.getChildAt(i);
            for (int j = 0; j < row.getChildCount(); j++) {
                MaterialButton btn = (MaterialButton) row.getChildAt(j);
                String letter = (String) btn.getTag();
                boolean guessed = controller.isLetterGuessed(letter);
                btn.setEnabled(!guessed);
                btn.setAlpha(guessed ? 0.3f : 1.0f);
            }
        }
    }

    private void showResultDialog(GameSession session) {
        boolean didWin = session.status == GameStatus.WON;
        new AlertDialog.Builder(this)
                .setTitle(didWin ? getString(R.string.you_won) : getString(R.string.try_again))
                .setMessage((didWin ? getString(R.string.nice_work) : getString(R.string.word_got_away))
                        + "\n\n" + getString(R.string.correct_word) + " " + session.originalWord)
                .setCancelable(false)
                .setNegativeButton(getString(R.string.home), (d, w) -> {
                    controller.resetSession();
                    finish();
                })
                .setPositiveButton(getString(R.string.play_again), (d, w) -> {
                    dialogShown = false;
                    controller.startGame(session.category);
                })
                .show();
    }
}
