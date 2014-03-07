package com.skladek.activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.EditText;

import com.parse.GetCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.skladek.Constants;
import com.skladek.R;
import com.sun.tools.internal.jxc.apt.Const;

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

        Intent intent = getIntent();
        if (intent == null) {
            return;
        }
        String username = intent.getExtras().getString(Constants.kUsernameKey);

        Log.d("BOOM", username);
        queryFromUsername(username);
    }

    private void queryFromUsername(String username) {
        ParseQuery<ParseUser> query = ParseUser.getQuery();
        query.whereEqualTo(Constants.kUsernameKey, username);
        query.getFirstInBackground(new GetCallback<ParseUser>() {
            @Override
            public void done(ParseUser parseUser, ParseException e) {
                if (e != null) {
                    Log.d("BOOM", "Exception" + e);
                }
                populateFromUser(parseUser);
            }
        });
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
