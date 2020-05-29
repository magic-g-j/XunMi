package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "posts", schema = "XunMi", catalog = "")
public class PostsEntity {
    private int postsId;
    private String postsTitle;
    private Integer postsBelongs;
    private String postsContent;
    private Integer postsCreator;
    private Timestamp postsCtime;
    private Integer postsLikes;
    private Integer postsDislikes;
    private Timestamp postsUpdateTime;

    @Id
    @Column(name = "posts_id")
    public int getPostsId() {
        return postsId;
    }

    public void setPostsId(int postsId) {
        this.postsId = postsId;
    }

    @Basic
    @Column(name = "posts_title")
    public String getPostsTitle() {
        return postsTitle;
    }

    public void setPostsTitle(String postsTitle) {
        this.postsTitle = postsTitle;
    }

    @Basic
    @Column(name = "posts_belongs")
    public Integer getPostsBelongs() {
        return postsBelongs;
    }

    public void setPostsBelongs(Integer postsBelongs) {
        this.postsBelongs = postsBelongs;
    }

    @Basic
    @Column(name = "posts_content")
    public String getPostsContent() {
        return postsContent;
    }

    public void setPostsContent(String postsContent) {
        this.postsContent = postsContent;
    }

    @Basic
    @Column(name = "posts_creator")
    public Integer getPostsCreator() {
        return postsCreator;
    }

    public void setPostsCreator(Integer postsCreator) {
        this.postsCreator = postsCreator;
    }

    @Basic
    @Column(name = "posts_ctime")
    public Timestamp getPostsCtime() {
        return postsCtime;
    }

    public void setPostsCtime(Timestamp postsCtime) {
        this.postsCtime = postsCtime;
    }

    @Basic
    @Column(name = "posts_likes")
    public Integer getPostsLikes() {
        return postsLikes;
    }

    public void setPostsLikes(Integer postsLikes) {
        this.postsLikes = postsLikes;
    }

    @Basic
    @Column(name = "posts_dislikes")
    public Integer getPostsDislikes() {
        return postsDislikes;
    }

    public void setPostsDislikes(Integer postsDislikes) {
        this.postsDislikes = postsDislikes;
    }

    @Basic
    @Column(name = "posts_update_time")
    public Timestamp getPostsUpdateTime() {
        return postsUpdateTime;
    }

    public void setPostsUpdateTime(Timestamp postsUpdateTime) {
        this.postsUpdateTime = postsUpdateTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PostsEntity that = (PostsEntity) o;
        return postsId == that.postsId &&
                Objects.equals(postsTitle, that.postsTitle) &&
                Objects.equals(postsBelongs, that.postsBelongs) &&
                Objects.equals(postsContent, that.postsContent) &&
                Objects.equals(postsCreator, that.postsCreator) &&
                Objects.equals(postsCtime, that.postsCtime) &&
                Objects.equals(postsLikes, that.postsLikes) &&
                Objects.equals(postsDislikes, that.postsDislikes) &&
                Objects.equals(postsUpdateTime, that.postsUpdateTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(postsId, postsTitle, postsBelongs, postsContent, postsCreator, postsCtime, postsLikes, postsDislikes, postsUpdateTime);
    }
}
