package com.tutulei.xunmi.bean;

import java.sql.Timestamp;

public class Posts {
    private int postsId;
    private String postsTitle;
    private Integer postsBelongs;
    private String postsContent;
    private Integer postsCreator;
    private Timestamp postsCtime;
    private Integer postsLikes;
    private Integer postsDislikes;
    private Timestamp postsUpdateTime;

    public int getPostsId() {
        return postsId;
    }

    public void setPostsId(int postsId) {
        this.postsId = postsId;
    }

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

    public Timestamp getPostsCtime() {
        return postsCtime;
    }

    public void setPostsCtime(Timestamp postsCtime) {
        this.postsCtime = postsCtime;
    }

    public Integer getPostsLikes() {
        return postsLikes;
    }

    public void setPostsLikes(Integer postsLikes) {
        this.postsLikes = postsLikes;
    }

    public Integer getPostsDislikes() {
        return postsDislikes;
    }

    public void setPostsDislikes(Integer postsDislikes) {
        this.postsDislikes = postsDislikes;
    }

    public Timestamp getPostsUpdateTime() {
        return postsUpdateTime;
    }

    public void setPostsUpdateTime(Timestamp postsUpdateTime) {
        this.postsUpdateTime = postsUpdateTime;
    }
}
