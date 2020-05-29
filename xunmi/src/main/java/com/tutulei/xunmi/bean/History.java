package com.tutulei.xunmi.bean;

import java.sql.Timestamp;

public class History {
    private int historyId;
    private Integer historyPosts;
    private Timestamp historyCtime;
    private Integer historySubject;
    private String historyTitle;
    public int getHistoryId() {
        return historyId;
    }

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    public Integer getHistoryPosts() {
        return historyPosts;
    }

    public void setHistoryPosts(Integer historyPosts) {
        this.historyPosts = historyPosts;
    }

    public Timestamp getHistoryCtime() {
        return historyCtime;
    }

    public void setHistoryCtime(Timestamp historyCtime) {
        this.historyCtime = historyCtime;
    }

    public Integer getHistorySubject() {
        return historySubject;
    }

    public void setHistorySubject(Integer historySubject) {
        this.historySubject = historySubject;
    }

    public String getHistoryTitle() {
        return historyTitle;
    }

    public void setHistoryTitle(String historyTitle) {
        this.historyTitle = historyTitle;
    }
}
