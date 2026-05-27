package com.fabriciodevbranch.paperhangman.view;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.View;

import androidx.annotation.Nullable;

import com.google.android.material.color.MaterialColors;

public class HangmanView extends View {

    private final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private int stage = 0;

    public HangmanView(Context context) {
        super(context);
        init();
    }

    public HangmanView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public HangmanView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init() {
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeWidth(8f);
        paint.setStrokeCap(Paint.Cap.ROUND);
    }

    public void setStage(int stage) {
        this.stage = Math.max(0, Math.min(6, stage));
        invalidate();
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        // Use the primary color from the theme
        int color = MaterialColors.getColor(this,
                com.google.android.material.R.attr.colorPrimary, 0xFF000000);
        paint.setColor(color);

        float w = getWidth();
        float h = getHeight();

        float baseY = h - 24f;
        float poleX = w * 0.2f;
        float topY = 36f;
        float nooseX = w * 0.65f;

        // Gallows structure
        canvas.drawLine(poleX - 40f, baseY, w * 0.8f, baseY, paint);   // base
        canvas.drawLine(poleX, baseY, poleX, topY, paint);              // pole
        canvas.drawLine(poleX, topY, nooseX, topY, paint);              // top bar
        canvas.drawLine(nooseX, topY, nooseX, topY + 40f, paint);       // noose

        float headCy = topY + 40f + 36f;
        float headR = 36f;

        if (stage >= 1) {
            canvas.drawCircle(nooseX, headCy, headR, paint);
        }
        float bodyTop = headCy + headR;
        float bodyBot = bodyTop + 80f;
        if (stage >= 2) {
            canvas.drawLine(nooseX, bodyTop, nooseX, bodyBot, paint);
        }
        if (stage >= 3) {
            canvas.drawLine(nooseX, bodyTop + 20f, nooseX - 40f, bodyTop + 50f, paint);
        }
        if (stage >= 4) {
            canvas.drawLine(nooseX, bodyTop + 20f, nooseX + 40f, bodyTop + 50f, paint);
        }
        if (stage >= 5) {
            canvas.drawLine(nooseX, bodyBot, nooseX - 36f, bodyBot + 50f, paint);
        }
        if (stage >= 6) {
            canvas.drawLine(nooseX, bodyBot, nooseX + 36f, bodyBot + 50f, paint);
        }
    }
}
