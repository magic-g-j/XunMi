package com.tutulei.xunmi.bean;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String userName;
    private String userPhone;
    private Byte userSex;
    private Integer userIdentity;
    private String userWords;
    private Timestamp userCtime;

    public Timestamp getUserCtime() {
        return userCtime;
    }

    public void setUserCtime(Timestamp userCtime) {
        this.userCtime = userCtime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public Byte getUserSex() {
        return userSex;
    }

    public void setUserSex(Byte userSex) {
        this.userSex = userSex;
    }

    public Integer getUserIdentity() {
        return userIdentity;
    }

    public void setUserIdentity(Integer userIdentity) {
        this.userIdentity = userIdentity;
    }

    public String getUserWords() {
        return userWords;
    }

    public void setUserWords(String userWords) {
        this.userWords = userWords;
    }
}
