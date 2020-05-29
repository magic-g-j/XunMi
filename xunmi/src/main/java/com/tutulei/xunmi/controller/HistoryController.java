package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.bean.History;
import com.tutulei.xunmi.bean.Posts;
import com.tutulei.xunmi.entity.HistoryEntity;
import com.tutulei.xunmi.repository.HistoryRepository;
import com.tutulei.xunmi.repository.PostsRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/history")
public class HistoryController {
    private final HistoryRepository repository;
    private final PostsRepository postsRepository;

    HistoryController(HistoryRepository repository,PostsRepository postsRepository){
        this.repository = repository;
        this.postsRepository = postsRepository;
    }

    //获取用户的帖子访问历史记录
    @GetMapping("/list")
    public List<History> History(@Param("userId")int userId){
        List<HistoryEntity> historyEntities = repository.findHistoryPostsByHistoryUser(userId);
        List<History> histories = new ArrayList<>();
        for(HistoryEntity historyEntity : historyEntities){
            History history = new History();
            BeanUtils.copyProperties(historyEntity, history);
            histories.add(history);
        }
        return histories;
    }

}
