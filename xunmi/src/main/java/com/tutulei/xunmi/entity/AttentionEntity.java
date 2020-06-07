package com.tutulei.xunmi.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "attention", schema = "XunMi", catalog = "")
public class AttentionEntity {
    private int attentionId;
    private String attentionSubject;
    private Integer attentionSubid;
    private Integer attentionUser;

    @Id
    @Column(name = "attention_id")
    public int getAttentionId() {
        return attentionId;
    }

    public void setAttentionId(int attentionId) {
        this.attentionId = attentionId;
    }

    @Basic
    @Column(name = "attention_subject")
    public String getAttentionSubject() {
        return attentionSubject;
    }

    public void setAttentionSubject(String attentionSubject) {
        this.attentionSubject = attentionSubject;
    }

    @Basic
    @Column(name = "attention_subid")
    public Integer getAttentionSubid() {
        return attentionSubid;
    }

    public void setAttentionSubid(Integer attentionSubid) {
        this.attentionSubid = attentionSubid;
    }

    @Basic
    @Column(name = "attention_user")
    public Integer getAttentionUser() {
        return attentionUser;
    }

    public void setAttentionUser(Integer attentionUser) {
        this.attentionUser = attentionUser;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AttentionEntity that = (AttentionEntity) o;
        return attentionId == that.attentionId &&
                Objects.equals(attentionSubject, that.attentionSubject) &&
                Objects.equals(attentionSubid, that.attentionSubid) &&
                Objects.equals(attentionUser, that.attentionUser);
    }

    @Override
    public int hashCode() {
        return Objects.hash(attentionId, attentionSubject, attentionSubid, attentionUser);
    }
}
