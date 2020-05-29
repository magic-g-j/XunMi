package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "reply", schema = "XunMi", catalog = "")
public class ReplyEntity {
    private int replyId;
    private Integer replyParent;
    private Byte replyParentType;
    private Integer replyCreator;
    private String replyContent;
    private Date replyCtime;
    private Integer replyLikes;
    private Integer replyDislikes;

    @Id
    @Column(name = "reply_id")
    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    @Basic
    @Column(name = "reply_parent")
    public Integer getReplyParent() {
        return replyParent;
    }

    public void setReplyParent(Integer replyParent) {
        this.replyParent = replyParent;
    }

    @Basic
    @Column(name = "reply_parent_type")
    public Byte getReplyParentType() {
        return replyParentType;
    }

    public void setReplyParentType(Byte replyParentType) {
        this.replyParentType = replyParentType;
    }

    @Basic
    @Column(name = "reply_creator")
    public Integer getReplyCreator() {
        return replyCreator;
    }

    public void setReplyCreator(Integer replyCreator) {
        this.replyCreator = replyCreator;
    }

    @Basic
    @Column(name = "reply_content")
    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    @Basic
    @Column(name = "reply_ctime")
    public Date getReplyCtime() {
        return replyCtime;
    }

    public void setReplyCtime(Date replyCtime) {
        this.replyCtime = replyCtime;
    }

    @Basic
    @Column(name = "reply_likes")
    public Integer getReplyLikes() {
        return replyLikes;
    }

    public void setReplyLikes(Integer replyLikes) {
        this.replyLikes = replyLikes;
    }

    @Basic
    @Column(name = "reply_dislikes")
    public Integer getReplyDislikes() {
        return replyDislikes;
    }

    public void setReplyDislikes(Integer replyDislikes) {
        this.replyDislikes = replyDislikes;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ReplyEntity that = (ReplyEntity) o;
        return replyId == that.replyId &&
                Objects.equals(replyParent, that.replyParent) &&
                Objects.equals(replyParentType, that.replyParentType) &&
                Objects.equals(replyCreator, that.replyCreator) &&
                Objects.equals(replyContent, that.replyContent) &&
                Objects.equals(replyCtime, that.replyCtime) &&
                Objects.equals(replyLikes, that.replyLikes) &&
                Objects.equals(replyDislikes, that.replyDislikes);
    }

    @Override
    public int hashCode() {
        return Objects.hash(replyId, replyParent, replyParentType, replyCreator, replyContent, replyCtime, replyLikes, replyDislikes);
    }
}
