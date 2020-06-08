package com.tutulei.xunmi.bean;

import java.sql.Timestamp;

public class Reply {
    private int replyId;
    private Integer replyParent;
    private Byte replyParentType;
    private Integer replyCreator;
    private String replyCreatorName;
    private String replyContent;
    private Timestamp replyCtime;
    private Integer replyLikes;
    private Integer replyDislikes;

    public String getReplyCreatorName() {
        return replyCreatorName;
    }

    public void setReplyCreatorName(String replyCreatorName) {
        this.replyCreatorName = replyCreatorName;
    }

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public Integer getReplyParent() {
        return replyParent;
    }

    public void setReplyParent(Integer replyParent) {
        this.replyParent = replyParent;
    }

    public Byte getReplyParentType() {
        return replyParentType;
    }

    public void setReplyParentType(Byte replyParentType) {
        this.replyParentType = replyParentType;
    }

    public Integer getReplyCreator() {
        return replyCreator;
    }

    public void setReplyCreator(Integer replyCreator) {
        this.replyCreator = replyCreator;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public Timestamp getReplyCtime() {
        return replyCtime;
    }

    public void setReplyCtime(Timestamp replyCtime) {
        this.replyCtime = replyCtime;
    }

    public Integer getReplyLikes() {
        return replyLikes;
    }

    public void setReplyLikes(Integer replyLikes) {
        this.replyLikes = replyLikes;
    }

    public Integer getReplyDislikes() {
        return replyDislikes;
    }

    public void setReplyDislikes(Integer replyDislikes) {
        this.replyDislikes = replyDislikes;
    }
}
