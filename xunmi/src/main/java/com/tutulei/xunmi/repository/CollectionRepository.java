package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.CollectionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CollectionRepository extends JpaRepository<CollectionEntity,Integer> {

    @Query(value = "select COUNT(*) from collection where collection_posts = :postsId",nativeQuery = true)
    Integer findCountByCollectionPosts(@Param("postsId") int postsId);
}
