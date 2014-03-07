package com.skladek.activity;

import com.parse.ParseObject;
import com.skladek.Constants;
import com.skladek.R;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;

import butterknife.ButterKnife;
import butterknife.InjectView;

/**
 * Main activity of the application
 */
public class MainActivity extends BaseActivity {

    @InjectView(R.id.signUpButton)
    Button signUpButton;

    @InjectView(R.id.logInButton)
    Button logInButton;

    @InjectView(R.id.allUsersButton)
    Button allUsersButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ButterKnife.inject(this);

        this.signUpButton.setOnClickListener(this.signUpListener());
        this.logInButton.setOnClickListener(this.logInListener());
        this.allUsersButton.setOnClickListener(this.allUsersListener());
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }

    private View.OnClickListener signUpListener() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                logInSignUp(false);
            }
        };
    }

    private View.OnClickListener logInListener() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                logInSignUp(true);
            }
        };
    }

    private View.OnClickListener allUsersListener() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                displayAllUsers();
            }
        };
    }

    private void logInSignUp (boolean logIn) {
        Intent intent = new Intent(this, LogInSignUpActivity.class);
        intent.putExtra(Constants.kLogInKey, logIn);
        startActivity(intent);
    }

    private void displayAllUsers() {
        Intent intent = new Intent(this, AllUsersActivity.class);
        startActivity(intent);
    }
}
