package com.example.ajax.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.ajax.dto.MemberDto;

@Mapper
public interface MemberMapper {
	// ID 중복 확인
	String selectMemberId(String id);
	// 회원가입
	int insertMember(MemberDto memberDto);
}
