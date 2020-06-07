package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.bean.History;
import com.tutulei.xunmi.bean.Posts;
import com.tutulei.xunmi.entity.HistoryEntity;
import com.tutulei.xunmi.repository.HistoryRepository;
import com.tutulei.xunmi.repository.PostsRepository;
import com.tutulei.xunmi.repository.SubjectRepository;
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
    private final SubjectRepository subjectRepository;

    HistoryController(HistoryRepository repository,SubjectRepository subjectRepository){
        this.repository = repository;
        this.subjectRepository = subjectRepository;
    }

    //获取用户的帖子访问历史记录
    @GetMapping("/list")
    public List<History> History(@Param("userId")int userId){
        List<HistoryEntity> historyEntities = repository.findByHistoryUserOrderByHistoryCtimeDesc(userId);
        List<History> histories = new ArrayList<>();
        for(HistoryEntity historyEntity : historyEntities){
            History history = new History();
            BeanUtils.copyProperties(historyEntity, history);
            history.setHistorySubjectName(subjectRepository.findSubjectNameBySubjectId(historyEntity.getHistorySubject()));
            histories.add(history);
        }
        return histories;
    }

}
