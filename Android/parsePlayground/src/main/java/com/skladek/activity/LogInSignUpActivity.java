package com.skladek.activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.skladek.Constants;
import com.skladek.R;

import butterknife.ButterKnife;
import butterknife.InjectView;

/**
 * Created by skladek on 3/6/14.
 */
public class LogInSignUpActivity extends BaseActivity {

    boolean logIn;

    @InjectView(R.id.usernameField)
    EditText usernameField;

    @InjectView(R.id.passwordField)
    EditText passwordField;

    @InjectView(R.id.emailField)
    EditText emailField;

    @InjectView(R.id.facebookButton)
    Button facebookButton;

    @InjectView(R.id.twitterButton)
    Button twitterButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_log_in_sign_up);

        ButterKnife.inject(this);

        Intent intent = getIntent();
        this.logIn = intent.getBooleanExtra(Constants.kLogInKey, false);

        Log.d("BOOM", "Yep" + intent.getBooleanExtra(Constants.kLogInKey, true));

        if (this.logIn) {
            this.emailField.setVisibility(View.GONE);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }

}
