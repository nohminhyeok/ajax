package com.example.ajax.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberDto {
	public String id;
	public String pw;
	public String gender;
	public int age;
	public String address;
}
