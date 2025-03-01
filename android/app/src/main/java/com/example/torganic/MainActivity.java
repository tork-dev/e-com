package com.thetork.kirei;

import android.os.Bundle; // Import Bundle
import androidx.activity.OnBackPressedCallback; // Import OnBackPressedCallback
import androidx.activity.OnBackPressedDispatcher; // Import OnBackPressedDispatcher
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragmentActivity;


public class MainActivity extends FlutterFragmentActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onBackPressed() {
        if (getSupportFragmentManager().getBackStackEntryCount() > 0) {
            getSupportFragmentManager().popBackStack(); // Pop to the previous screen
        } else {
            super.onBackPressed(); // Use Flutter's navigation
        }
    }
}
