package com.tutulei.xunmi.view;

public class ReplyMsg {
    private Integer replyParent;
    private Integer replyParentType;
    private Integer replyCreator;
    private String replyContent;

    public Integer getReplyParent() {
        return replyParent;
    }

    public void setReplyParent(Integer replyParent) {
        this.replyParent = replyParent;
    }

    public Integer getReplyParentType() {
        return replyParentType;
    }

    public void setReplyParentType(Integer replyParentType) {
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
}
