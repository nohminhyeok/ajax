package com.example.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.ajax.mapper.ContinentMapper;

@Controller
public class CntnntController {
	@Autowired ContinentMapper continentMapper;
	
	@GetMapping("/cntnntList")
	public String continentList(Model model) {
		model.addAttribute("cntnntList", continentMapper.selectContinentList());
		return "cntnntList";
	}
}