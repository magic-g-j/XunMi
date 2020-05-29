package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "history", schema = "XunMi", catalog = "")
public class HistoryEntity {
    private int historyId;
    private Integer historyUser;
    private Integer historyPosts;
    private Timestamp historyCtime;
    private Integer historySubject;
    private String historyTitle;

    @Id
    @Column(name = "history_id")
    public int getHistoryId() {
        return historyId;
    }

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    @Basic
    @Column(name = "history_user")
    public Integer getHistoryUser() {
        return historyUser;
    }

    public void setHistoryUser(Integer historyUser) {
        this.historyUser = historyUser;
    }

    @Basic
    @Column(name = "history_posts")
    public Integer getHistoryPosts() {
        return historyPosts;
    }

    public void setHistoryPosts(Integer historyPosts) {
        this.historyPosts = historyPosts;
    }

    @Basic
    @Column(name = "history_ctime")
    public Timestamp getHistoryCtime() {
        return historyCtime;
    }

    public void setHistoryCtime(Timestamp historyCtime) {
        this.historyCtime = historyCtime;
    }

    @Basic
    @Column(name = "history_subject")
    public Integer getHistorySubject() {
        return historySubject;
    }

    public void setHistorySubject(Integer historySubject) {
        this.historySubject = historySubject;
    }

    @Basic
    @Column(name = "history_title")
    public String getHistoryTitle() {
        return historyTitle;
    }

    public void setHistoryTitle(String historyTitle) {
        this.historyTitle = historyTitle;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        HistoryEntity that = (HistoryEntity) o;
        return historyId == that.historyId &&
                Objects.equals(historyUser, that.historyUser) &&
                Objects.equals(historyPosts, that.historyPosts) &&
                Objects.equals(historyCtime, that.historyCtime) &&
                Objects.equals(historySubject, that.historySubject) &&
                Objects.equals(historyTitle, that.historyTitle);
    }

    @Override
    public int hashCode() {
        return Objects.hash(historyId, historyUser, historyPosts, historyCtime, historySubject, historyTitle);
    }
}
