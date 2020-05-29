package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "follow", schema = "XunMi", catalog = "")
public class FollowEntity {
    private int followId;
    private int followMaster;
    private int followSlave;

    @Id
    @Column(name = "follow_id")
    public int getFollowId() {
        return followId;
    }

    public void setFollowId(int followId) {
        this.followId = followId;
    }

    @Basic
    @Column(name = "follow_master")
    public int getFollowMaster() {
        return followMaster;
    }

    public void setFollowMaster(int followMaster) {
        this.followMaster = followMaster;
    }

    @Basic
    @Column(name = "follow_slave")
    public int getFollowSlave() {
        return followSlave;
    }

    public void setFollowSlave(int followSlave) {
        this.followSlave = followSlave;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FollowEntity that = (FollowEntity) o;
        return followId == that.followId &&
                followMaster == that.followMaster &&
                followSlave == that.followSlave;
    }

    @Override
    public int hashCode() {
        return Objects.hash(followId, followMaster, followSlave);
    }
}
