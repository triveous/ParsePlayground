package com.skladek;

import com.skladek.dependencyinjection.modules.AndroidModule;

import android.app.Application;

import java.util.Arrays;
import java.util.List;

import butterknife.ButterKnife;
import dagger.ObjectGraph;

public class ParsePlaygroundApplication extends Application {

    private static ParsePlaygroundApplication sInstance;

    private ObjectGraph mGraph;

    /**
     * Only use this for easy access to inject function
     */
    public static ParsePlaygroundApplication getInstance() {
        return sInstance;
    }

    @Override
    public void onCreate() {
        super.onCreate();

        // Setup debugging for butterknife
        ButterKnife.setDebug(BuildConfig.DEBUG);

        // Create ability to get instance
        sInstance = this;

        // Setup DI
        mGraph = ObjectGraph.create(getModules().toArray());
    }

    /**
     * Used for injecting dependencies
     *
     * @param object object that needs dependencies injected
     */
    public void inject(Object object) {
        mGraph.inject(object);
    }

    /**
     * Gets mGraph.
     *
     * @return Value of mGraph.
     */
    public ObjectGraph getApplicationGraph() {
        return mGraph;
    }

    /**
     * Creates a list containing all the modules required for dagger
     */
    private List<Object> getModules() {
        return Arrays.<Object>asList(
                new AndroidModule(this)
        );
    }
}
