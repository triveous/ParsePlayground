package com.skladek.activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.parse.LogInCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;
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

    @InjectView(R.id.submitButton)
    Button submitButton;

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

        if (this.logIn) {
            this.emailField.setVisibility(View.GONE);
            this.submitButton.setOnClickListener(this.logInListener());
        } else {
            this.submitButton.setOnClickListener(this.signUpListener());
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }

    private View.OnClickListener logInListener() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                logIn();
            }
        };
    }

    private View.OnClickListener signUpListener() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                signUp();
            }
        };
    }

    private void logIn() {
        ParseUser.logInInBackground(this.usernameField.getText().toString(), this.passwordField.getText().toString(), new LogInCallback() {
            @Override
            public void done(ParseUser parseUser, ParseException e) {
                if (parseUser != null) {
                    pushUserForm();
                } else {
                    Log.d("Exception", e.toString());
                }
            }
        });
    }

    private void signUp() {
        ParseUser user = new ParseUser();
        user.setUsername(this.usernameField.getText().toString());
        user.setPassword(this.passwordField.getText().toString());

        String email = this.emailField.getText().toString();
        if (email.length() > 0) {
            user.setEmail(email);
        }

        user.signUpInBackground(new SignUpCallback() {
            @Override
            public void done(ParseException e) {
                if (e == null) {
                    pushUserForm();
                } else {
                    Log.d("Error", e.getLocalizedMessage());
                }
            }
        });
    }

    private void pushUserForm() {
        Intent intent = new Intent(this, UserFormActivity.class);
        startActivity(intent);
    }
}
