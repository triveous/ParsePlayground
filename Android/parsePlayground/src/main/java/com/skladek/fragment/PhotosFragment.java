package com.skladek.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.skladek.R;

import butterknife.ButterKnife;

/**
 * Created by skladek on 3/6/14.
 */
public class PhotosFragment extends BaseFragment {

    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);
        View view = inflater.inflate(R.layout.fragment_photos, container, false);
        ButterKnife.inject(this, view);

        return view;
    }

}
