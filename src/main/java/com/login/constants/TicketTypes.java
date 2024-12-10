package com.login.constants;

public enum TicketTypes {
    ADULT("Adult"),
    CHILDREN("Children"),
    DISABLED("Disabled"),
    SENIORS("Seniors");

    private final String displayName;

    TicketTypes(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}