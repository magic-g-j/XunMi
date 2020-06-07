package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.bean.Posts;
import com.tutulei.xunmi.entity.HistoryEntity;
import com.tutulei.xunmi.entity.PostsEntity;
import com.tutulei.xunmi.repository.*;
import com.tutulei.xunmi.bean.PostsForList;
import com.tutulei.xunmi.view.NewPostsMsg;
import org.springframework.beans.BeanUtils;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


@RestController
@RequestMapping("/posts")
public class PostsController {

    private final PostsRepository repository;
    private final HistoryRepository historyRepository;
    private final PostsRepository postsRepository;
    private final SubjectRepository subjectRepository;
    private final CollectionRepository collectionRepository;
    private final UserRepository userRepository;
    private final ReplyRepository replyRepository;
    PostsController(PostsRepository repository,
                    HistoryRepository historyRepository,
                    PostsRepository postsRepository,
                    SubjectRepository subjectRepository,
                    UserRepository userRepository,
                    CollectionRepository collectionRepository,
                    ReplyRepository replyRepository){
        this.repository = repository;
        this.historyRepository = historyRepository;
        this.postsRepository = postsRepository;
        this.subjectRepository = subjectRepository;
        this.userRepository = userRepository;
        this.collectionRepository = collectionRepository;
        this.replyRepository = replyRepository;
    }

    //新建帖子
    @PostMapping("/newPosts")
    public Posts NewPosts(@RequestBody NewPostsMsg newPostsMsg){
        PostsEntity postsEntity = new PostsEntity();
        BeanUtils.copyProperties(newPostsMsg, postsEntity);
        postsEntity.setPostsDislikes(0);
        postsEntity.setPostsLikes(0);
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        postsEntity.setPostsCtime(timestamp);
        postsEntity.setPostsUpdateTime(timestamp);
        Posts posts = new Posts();
        BeanUtils.copyProperties(postsRepository.save(postsEntity),posts);
        return posts;
    }

    //通过id获取一个帖子访问详情内容(会增加访问历史)
    @GetMapping("/getOne")
    public Posts GetOnePosts(@Param("postsId")int postsId,@Param("userId")int userId){
        Posts posts = new Posts();
        PostsEntity postsEntity = repository.findByPostsId(postsId);
        if(postsEntity != null){
            BeanUtils.copyProperties(postsEntity, posts);
            addHistoryRecording(postsEntity,userId);
            return posts;
        }
        posts.setPostsId(-1);
        return posts;
    }
    //获取某学科圈的帖子列表(按回复时间排序)
    @GetMapping("/getListForSubject/updateTime")
    public List<PostsForList>  GetListForSubjectOrderByUpdateTime(@Param("subjectId")int subjectId){
        List<PostsEntity> postsEntities = repository.findByPostsBelongsOrderByPostsUpdateTimeDesc(subjectId);
        List<PostsForList> postsForLists = new ArrayList<>();
        turnToListItem(postsEntities, postsForLists);
        return  postsForLists;
    }
    //获取某学科圈的帖子列表(按开贴时间排序)
    @GetMapping("/getListForSubject/createTime")
    public List<PostsForList> GetListForSubjectOrderByCreateTime(@Param("subjectId")int subjectId){
        List<PostsEntity> postsEntities = repository.findByPostsBelongsOrderByPostsCtimeDesc(subjectId);
        List<PostsForList> postsForLists = new ArrayList<>();
        turnToListItem(postsEntities, postsForLists);
        return  postsForLists;
    }
    //获取某用户发的帖子列表（按回复时间）
    @GetMapping("/getListForMe/updateTime")
    public List<PostsForList> GetCountForMeOrderByUpdateTime(@Param("userId")int userId){
        List<PostsEntity> postsEntities = repository.findByPostsCreatorOrderByPostsUpdateTimeDesc(userId);
        List<PostsForList> postsForLists = new ArrayList<>();
        turnToListItem(postsEntities, postsForLists);
        return postsForLists;
    }
    //获取某用户发的帖子列表（按发帖时间）
    @GetMapping("/getListForMe/createTime")
    public List<PostsForList> GetCountForMeOrderByCreateTime(@Param("userId")int userId){
        List<PostsEntity> postsEntities = repository.findByPostsCreatorOrderByPostsCtimeDesc(userId);
        List<PostsForList> postsForLists = new ArrayList<>();
        turnToListItem(postsEntities, postsForLists);
        return postsForLists;
    }
    //获取某学科圈的帖子总数
    @GetMapping("/getListForSubject/count")
    public Integer GetCountForSubject(@Param("subjectId")int subjectId){
        return repository.countByPostsBelongs(subjectId);
    }
    //获取某用户的发帖总数
    @GetMapping("/getListForMe/count")
    public Integer GetCountForMe(@Param("userId")int userId){
        return repository.countByPostsCreator(userId);
    }

    //通过用户id，获取给用户推荐的帖子列表
    //用户推荐规则：根据历史记录中用户访问的帖子，列出频繁访问的学科，推荐这些学科的最新帖子
    @GetMapping("/myList")
    public List<PostsForList> GetList(@Param("userId") int userId){
        List<PostsForList> homeList = new ArrayList<>();
        List<Integer> SubjectList = historyRepository.findHistorySubjectByHistoryUser(userId);
        while(SubjectList.size()<5){
            SubjectList.add(-11);
        }
        List<PostsEntity> entityList = postsRepository.findRecommendPosts(SubjectList.get(0),SubjectList.get(1),SubjectList.get(2),SubjectList.get(3),SubjectList.get(4));
        while(entityList.size()<12){
            List<PostsEntity> addList = postsRepository.findNewPosts(12-entityList.size());
            entityList.addAll(addList);
        }
        turnToListItem(entityList, homeList);
        return homeList;
    }
    private void turnToListItem(List<PostsEntity> postsEntities, List<PostsForList> postsForLists) {
        for(PostsEntity p:postsEntities){
            PostsForList item = new PostsForList();
            BeanUtils.copyProperties(p,item);
            item.setSubjectName(subjectRepository.findSubjectNameBySubjectId(p.getPostsBelongs()));
            item.setCollections(collectionRepository.findCountByCollectionPosts(p.getPostsBelongs()));
            item.setCreatorName(userRepository.findUserNameByUserId(p.getPostsCreator()));
            item.setRepliesCount(replyRepository.countByReplyParentAndReplyParentType(p.getPostsId(),0));
            postsForLists.add(item);
        }
    }

    private void addHistoryRecording(PostsEntity postsEntity,int userId){
        HistoryEntity h = historyRepository.findByHistoryPostsAndHistoryUser(postsEntity.getPostsId(),userId);
        if(h!=null){
            h.setHistoryCtime(new Timestamp(System.currentTimeMillis()));
            historyRepository.saveAndFlush(h);
            return;
        }
        HistoryEntity historyEntity = new HistoryEntity();
        historyEntity.setHistorySubject(postsEntity.getPostsBelongs());
        historyEntity.setHistoryPosts(postsEntity.getPostsId());
        historyEntity.setHistoryUser(userId);
        historyEntity.setHistoryTitle(postsEntity.getPostsTitle());
        historyEntity.setHistoryCtime(new Timestamp(System.currentTimeMillis()));
        historyRepository.save(historyEntity);
    }
}
