package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.AttentionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AttentionRepository extends JpaRepository<AttentionEntity,Integer> {
    List<AttentionEntity> findByAttentionUser(int user);
    List<AttentionEntity> findByAttentionSubjectLike(String key);

    Integer countByAttentionUser(int user);
}
