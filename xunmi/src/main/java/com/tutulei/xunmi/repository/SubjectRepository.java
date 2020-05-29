package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.SubjectEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SubjectRepository extends JpaRepository<SubjectEntity,Integer> {

    @Query(value = "select subject_name from subject where subject_id = :subjectId",nativeQuery = true)
    String findSubjectNameBySubjectId(@Param("subjectId")int subjectId);
}
