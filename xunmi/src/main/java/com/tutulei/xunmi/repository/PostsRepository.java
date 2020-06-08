package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.bean.Posts;
import com.tutulei.xunmi.entity.PostsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PostsRepository extends JpaRepository<PostsEntity,Integer> {

    PostsEntity findByPostsId(Integer postsId);
    Integer countByPostsBelongs(Integer subjectId);
    List<PostsEntity> findByPostsBelongsOrderByPostsCtimeDesc(Integer subjectId);
    List<PostsEntity> findByPostsBelongsOrderByPostsUpdateTimeDesc(Integer subjectId);
    Integer countByPostsCreator(Integer userId);
    List<PostsEntity> findByPostsCreatorOrderByPostsCtimeDesc(Integer userId);
    List<PostsEntity> findByPostsCreatorOrderByPostsUpdateTimeDesc(Integer userId);

    @Query(value = "SELECT * FROM posts WHERE TO_DAYS(NOW()) - TO_DAYS(posts_update_time) <= 10 AND posts_id IN(:id1,:id2,:id3,:id4,:id4,:id5) ORDER BY field(posts_id,:id1,:id2,:id3,:id4,:id4,:id5) LIMIT 10",nativeQuery = true)
    List<PostsEntity> findRecommendPosts(@Param("id1")Integer id1,@Param("id2")Integer id2,@Param("id3")Integer id3,@Param("id4")Integer id4,@Param("id5")Integer id5);

    @Query(value = "select * from posts ORDER BY posts_update_time DESC LIMIT :num",nativeQuery = true)
    List<PostsEntity> findNewPosts(@Param("num")int num);

    @Query(value = "select * from posts WHERE posts_id IN (:list) ORDER BY field(posts_id,:list)",nativeQuery = true)
    List<PostsEntity> findByPostsIdIn(@Param("list") List<Integer> list);

    @Query(value = "SELECT * FROM posts WHERE MATCH (posts_title,posts_content) AGAINST (:k IN NATURAL LANGUAGE MODE) Order BY posts_ctime DESC",nativeQuery = true)
    List<PostsEntity> searchPostsWithFullTextOrderByPostsCtime(@Param("k") String k);

    @Query(value = "SELECT * FROM posts WHERE MATCH (posts_title,posts_content) AGAINST (:k IN NATURAL LANGUAGE MODE) Order BY posts_update_time DESC",nativeQuery = true)
    List<PostsEntity> searchPostsWithFullTextOrderByPostsUpdateTime(@Param("k") String k);

}
