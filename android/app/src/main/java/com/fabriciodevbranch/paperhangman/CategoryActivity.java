package com.fabriciodevbranch.paperhangman;

import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.widget.LinearLayout;

import androidx.appcompat.app.AppCompatActivity;

import com.fabriciodevbranch.paperhangman.controller.GameController;
import com.fabriciodevbranch.paperhangman.model.Category;
import com.google.android.material.button.MaterialButton;
import com.google.android.material.card.MaterialCardView;
import android.widget.TextView;
import android.graphics.Typeface;

public class CategoryActivity extends AppCompatActivity implements GameController.GameListener {

    private GameController controller;
    private LinearLayout categoryList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_category);

        controller = GameController.getInstance();

        if (getSupportActionBar() != null) {
            getSupportActionBar().setTitle(getString(R.string.choose_category));
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }

        categoryList = findViewById(R.id.categoryList);
        MaterialButton btnStartSelected = findViewById(R.id.btnStartSelected);
        btnStartSelected.setOnClickListener(v -> {
            controller.startGame(controller.getSelectedCategory());
            startActivity(new Intent(this, GameActivity.class));
        });

        buildCategoryList();
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
        // Rebuild list to reflect selected state changes
        categoryList.removeAllViews();
        buildCategoryList();
    }

    private void buildCategoryList() {
        int dp8 = (int) (8 * getResources().getDisplayMetrics().density);
        int dp16 = dp8 * 2;

        for (Category cat : Category.VALUES) {
            MaterialCardView card = new MaterialCardView(this);
            LinearLayout.LayoutParams cardParams = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT);
            cardParams.setMargins(0, 0, 0, dp8);
            card.setLayoutParams(cardParams);
            card.setRadius(dp8 * 1.5f);
            card.setCardElevation(dp8 / 2f);
            card.setUseCompatPadding(true);

            LinearLayout row = new LinearLayout(this);
            row.setOrientation(LinearLayout.HORIZONTAL);
            row.setGravity(Gravity.CENTER_VERTICAL);
            row.setPadding(dp16, dp16, dp16, dp16);

            boolean isSelected = controller.getSelectedCategory() == cat;

            TextView tvCheck = new TextView(this);
            tvCheck.setText(isSelected ? "✓  " : "○  ");
            tvCheck.setTextSize(18f);
            row.addView(tvCheck);

            TextView tvTitle = new TextView(this);
            tvTitle.setText(cat.title);
            tvTitle.setTextSize(18f);
            if (isSelected) {
                tvTitle.setTypeface(null, Typeface.BOLD);
            }
            LinearLayout.LayoutParams titleParams = new LinearLayout.LayoutParams(
                    0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f);
            tvTitle.setLayoutParams(titleParams);
            row.addView(tvTitle);

            TextView tvSub = new TextView(this);
            tvSub.setText(cat == Category.RANDOM ? getString(R.string.all_lists) : getString(R.string.local_words));
            tvSub.setTextSize(12f);
            row.addView(tvSub);

            card.addView(row);
            card.setOnClickListener(v -> controller.selectCategory(cat));
            categoryList.addView(card);
        }
    }
}
