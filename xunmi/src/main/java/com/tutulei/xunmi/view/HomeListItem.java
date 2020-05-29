package com.tutulei.xunmi.view;

public class HomeListItem {
    private int postsId;
    private String postsTitle;
    private Integer postsBelongs;
    private String subjectName;
    private Integer postsCreator;
    private String creatorName;
    private Integer postsLikes;
    private Integer postsDislikes;
    private Integer collections;
    private Integer repliesCount;

    public Integer getRepliesCount() {
        return repliesCount;
    }

    public void setRepliesCount(Integer repliesCount) {
        this.repliesCount = repliesCount;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    public Integer getCollections() {
        return collections;
    }

    public void setCollections(Integer collections) {
        this.collections = collections;
    }

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

    public Integer getPostsCreator() {
        return postsCreator;
    }

    public void setPostsCreator(Integer postsCreator) {
        this.postsCreator = postsCreator;
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

}
