package io.flutter.plugins;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;



import android.content.Context;
import android.os.Bundle;
import android.view.View;

public interface SplashScreenInterface{
    
    @Nullable
    public View createSplashView(
      @NonNull Context context,
      @Nullable Bundle savedInstanceState
    );

    public void transitionToFlutter(@NonNull Runnable onTransitionComplete);
}