package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "collection", schema = "XunMi", catalog = "")
public class CollectionEntity {
    private int collectionId;
    private Integer collectionUser;
    private Integer collectionPosts;
    private Date collectionCtime;
    private Integer collectionState;

    @Id
    @Column(name = "collection_id")
    public int getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(int collectionId) {
        this.collectionId = collectionId;
    }

    @Basic
    @Column(name = "collection_user")
    public Integer getCollectionUser() {
        return collectionUser;
    }

    public void setCollectionUser(Integer collectionUser) {
        this.collectionUser = collectionUser;
    }

    @Basic
    @Column(name = "collection_posts")
    public Integer getCollectionPosts() {
        return collectionPosts;
    }

    public void setCollectionPosts(Integer collectionPosts) {
        this.collectionPosts = collectionPosts;
    }

    @Basic
    @Column(name = "collection_ctime")
    public Date getCollectionCtime() {
        return collectionCtime;
    }

    public void setCollectionCtime(Date collectionCtime) {
        this.collectionCtime = collectionCtime;
    }

    @Basic
    @Column(name = "collection_state")
    public Integer getCollectionState() {
        return collectionState;
    }

    public void setCollectionState(Integer collectionState) {
        this.collectionState = collectionState;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CollectionEntity that = (CollectionEntity) o;
        return collectionId == that.collectionId &&
                Objects.equals(collectionUser, that.collectionUser) &&
                Objects.equals(collectionPosts, that.collectionPosts) &&
                Objects.equals(collectionCtime, that.collectionCtime) &&
                Objects.equals(collectionState, that.collectionState);
    }

    @Override
    public int hashCode() {
        return Objects.hash(collectionId, collectionUser, collectionPosts, collectionCtime, collectionState);
    }
}
