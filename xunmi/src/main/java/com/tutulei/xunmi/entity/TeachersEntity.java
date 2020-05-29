package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "teachers", schema = "XunMi", catalog = "")
public class TeachersEntity {
    private int teachersId;
    private int teachersSubject;
    private int teachersUser;
    private String teachersSchool;
    private String teachersCode;

    @Id
    @Column(name = "teachers_id")
    public int getTeachersId() {
        return teachersId;
    }

    public void setTeachersId(int teachersId) {
        this.teachersId = teachersId;
    }

    @Basic
    @Column(name = "teachers_subject")
    public int getTeachersSubject() {
        return teachersSubject;
    }

    public void setTeachersSubject(int teachersSubject) {
        this.teachersSubject = teachersSubject;
    }

    @Basic
    @Column(name = "teachers_user")
    public int getTeachersUser() {
        return teachersUser;
    }

    public void setTeachersUser(int teachersUser) {
        this.teachersUser = teachersUser;
    }

    @Basic
    @Column(name = "teachers_school")
    public String getTeachersSchool() {
        return teachersSchool;
    }

    public void setTeachersSchool(String teachersSchool) {
        this.teachersSchool = teachersSchool;
    }

    @Basic
    @Column(name = "teachers_code")
    public String getTeachersCode() {
        return teachersCode;
    }

    public void setTeachersCode(String teachersCode) {
        this.teachersCode = teachersCode;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeachersEntity that = (TeachersEntity) o;
        return teachersId == that.teachersId &&
                teachersSubject == that.teachersSubject &&
                teachersUser == that.teachersUser &&
                Objects.equals(teachersSchool, that.teachersSchool) &&
                Objects.equals(teachersCode, that.teachersCode);
    }

    @Override
    public int hashCode() {
        return Objects.hash(teachersId, teachersSubject, teachersUser, teachersSchool, teachersCode);
    }
}
