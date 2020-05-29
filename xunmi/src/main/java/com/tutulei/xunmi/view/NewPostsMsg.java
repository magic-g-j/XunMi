package com.tutulei.xunmi.view;

import java.sql.Timestamp;

public class NewPostsMsg {
    private String postsTitle;
    private Integer postsBelongs;
    private String postsContent;
    private Integer postsCreator;

    public String getPostsTitle() {
        return postsTitle;
    }

    public void setPostsTitle(String postsTitle) {
        this.postsTitle = postsTitle;
    }

    public Integer getPostsBelongs() {
        return postsBelongs;
    }

    public void setPostsBelongs(Integer postsBelongs) {
        this.postsBelongs = postsBelongs;
    }

    public String getPostsContent() {
        return postsContent;
    }

    public void setPostsContent(String postsContent) {
        this.postsContent = postsContent;
    }

    public Integer getPostsCreator() {
        return postsCreator;
    }

    public void setPostsCreator(Integer postsCreator) {
        this.postsCreator = postsCreator;
    }
}
