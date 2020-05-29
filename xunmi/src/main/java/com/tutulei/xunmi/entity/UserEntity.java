package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "user", schema = "XunMi", catalog = "")
public class UserEntity {
    private int userId;
    private String userName;
    private String userPhone;
    private String userPassword;
    private Byte userSex;
    private Integer userIdentity;
    private String userWords;
    private Timestamp userCtime;

    @Id
    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "user_name")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    @Column(name = "user_phone")
    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    @Basic
    @Column(name = "user_password")
    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    @Basic
    @Column(name = "user_sex")
    public Byte getUserSex() {
        return userSex;
    }

    public void setUserSex(Byte userSex) {
        this.userSex = userSex;
    }

    @Basic
    @Column(name = "user_identity")
    public Integer getUserIdentity() {
        return userIdentity;
    }

    public void setUserIdentity(Integer userIdentity) {
        this.userIdentity = userIdentity;
    }

    @Basic
    @Column(name = "user_words")
    public String getUserWords() {
        return userWords;
    }

    public void setUserWords(String userWords) {
        this.userWords = userWords;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserEntity that = (UserEntity) o;
        return userId == that.userId &&
                Objects.equals(userName, that.userName) &&
                Objects.equals(userPhone, that.userPhone) &&
                Objects.equals(userPassword, that.userPassword) &&
                Objects.equals(userSex, that.userSex) &&
                Objects.equals(userIdentity, that.userIdentity) &&
                Objects.equals(userWords, that.userWords);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, userName, userPhone, userPassword, userSex, userIdentity, userWords);
    }

    @Basic
    @Column(name = "user_ctime")
    public Timestamp getUserCtime() {
        return userCtime;
    }

    public void setUserCtime(Timestamp userCtime) {
        this.userCtime = userCtime;
    }
}
