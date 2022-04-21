package com.iu.boot3.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	
	// 회원가입
	public int signUp(MemberVO memberVO) throws Exception;
	
	// 로그인
	public MemberVO login(MemberVO memberVO) throws Exception;
	
	// mypage
	public MemberVO myPage(MemberVO memverVO) throws Exception;
	
	// 회원수정
	public int memberUpdate(MemberVO memberVO) throws Exception;
	
	// 회원탈퇴
	public int memberDelete(MemberVO memberVO) throws Exception;
	
	// 파일 추가
	public int setAddFile(MemberFileVO memberFileVO) throws Exception;
	
	// 파일 상세정보
	public MemberVO getDetailFile(MemberVO memverVO) throws Exception;
	
	// 파일 삭제
	public int setDeleteFile(MemberFileVO memberFileVO) throws Exception;
	
	
}