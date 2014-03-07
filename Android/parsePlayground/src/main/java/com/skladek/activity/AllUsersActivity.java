package com.skladek.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseQuery;
import com.parse.ParseUser;
import com.skladek.Constants;
import com.skladek.R;

import java.util.List;

import javax.xml.soap.Text;

import butterknife.ButterKnife;
import butterknife.InjectView;

/**
 * Created by skladek on 3/6/14.
 */
public class AllUsersActivity extends BaseActivity {
    @InjectView(R.id.allUsersList)
    ListView allUsersList;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_all_users);

        ButterKnife.inject(this);

        fetchUsers();
    }

    private void fetchUsers() {
        ParseQuery<ParseUser> query = ParseUser.getQuery();
        query.orderByAscending(Constants.kUsernameKey);
        query.findInBackground(new FindCallback<ParseUser>() {
            @Override
            public void done(List<ParseUser> parseUsers, ParseException e) {
                populateListView(parseUsers);
            }
        });
    }

    private void populateListView(List<ParseUser> users) {
        UsersArrayAdapter adapter = new UsersArrayAdapter(users, this);

        allUsersList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                displayUserForm(position);
            }
        });

        allUsersList.setAdapter(adapter);
    }

    private void displayUserForm(int position) {
        UsersArrayAdapter adapter = (UsersArrayAdapter)this.allUsersList.getAdapter();
        ParseUser user = adapter.getItem(position);
        Intent intent = new Intent(this, UserFormActivity.class);
        intent.putExtra(Constants.kUsernameKey, user.getUsername());
        startActivity(intent);
    }

    private class UsersArrayAdapter extends BaseAdapter {

        private Activity activity;
        private List<ParseUser> userList;

        public UsersArrayAdapter(List<ParseUser> users, Activity activity) {
            this.userList = users;
            this.activity = activity;
        }

        @Override
        public int getCount() {
            return userList.size();
        }

        @Override
        public ParseUser getItem(int position) {
            return userList.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View view = convertView;
            if (convertView == null) {
                view = new TextView(activity);
            }

            ParseUser user = getItem(position);
            ((TextView)view).setText(user.getUsername());

            return view;
        }
    }
}
