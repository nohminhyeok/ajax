package com.example.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.ajax.dto.MemberDto;
import com.example.ajax.mapper.MemberMapper;

@Controller
public class MemberController {
	@Autowired MemberMapper memberMapper;
	
	@GetMapping("/joinMember")
	public String joinMember() {
		return "joinMember";
	}
	
	@PostMapping("/joinMember")
	public String joinMember(@RequestParam String id
			                 ,@RequestParam String pw1
	                         ,@RequestParam String gender
	                         ,@RequestParam int age
	                         ,@RequestParam String postcode
	                         ,@RequestParam String roadAddress
	                         ,@RequestParam String jibunAddress
	                         ,@RequestParam String detailAddress
	                         ,@RequestParam String extraAddress) {

        MemberDto memberDto = new MemberDto();
        memberDto.setId(id);
        memberDto.setPw(pw1);
        memberDto.setGender(gender);
        memberDto.setAge(age);
        memberDto.setAddress(postcode+" "+roadAddress+" "+jibunAddress+" "+detailAddress+" "+extraAddress);

        // 매퍼를 통해 DB에 직접 저장
        int result = memberMapper.insertMember(memberDto);
        if (result > 0) {
            return "/welcome";
        }
        return "redirect:/";
    }
}
