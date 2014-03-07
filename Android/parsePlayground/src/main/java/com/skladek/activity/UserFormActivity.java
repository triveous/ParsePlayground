package com.skladek.activity;

import android.os.Bundle;
import android.util.Log;
import android.widget.EditText;

import com.parse.ParseUser;
import com.skladek.Constants;
import com.skladek.R;

import butterknife.ButterKnife;
import butterknife.InjectView;

/**
 * Created by skladek on 3/6/14.
 */
public class UserFormActivity extends BaseActivity {

    @InjectView(R.id.usernameField)
    EditText username;

    @InjectView(R.id.passwordField)
    EditText password;

    @InjectView(R.id.emailField)
    EditText email;

    @InjectView(R.id.firstField)
    EditText first;

    @InjectView(R.id.lastField)
    EditText last;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_form);

        ButterKnife.inject(this);

        populateFromUser(null);
    }

    private void populateFromUser(ParseUser user) {
        if (user == null) {
            user = ParseUser.getCurrentUser();
        }

        this.username.setText(user.getUsername());
        this.email.setText(user.getEmail());
        this.first.setText(user.getString(Constants.kFirstNameKey));
        this.last.setText(user.getString(Constants.kLastNameKey));
    }
}
