package com.skladek;

/**
 * Constants File The one stop place for changing values in an application. Hard and fast rules, any
 * value that may change between dev/prod builds should go here so there is only one file to look at
 * and go through
 */
public final class Constants {

    public static final String kLogInKey = "logIn";
    public static final String kUsernameKey = "username";
    public static final String kFirstNameKey = "firstname";
    public static final String kLastNameKey = "lastname";

    /**
     * Suppress default constructor for noninstantiability
     */
    private Constants() {
        throw new AssertionError();
    }
}
