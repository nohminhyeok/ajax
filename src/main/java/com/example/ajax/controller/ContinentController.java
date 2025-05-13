package com.example.ajax.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.ajax.mapper.ContinentMapper;

@Controller
public class ContinentController {
	@Autowired ContinentMapper continentMapper;
	
	@GetMapping({"/","/continentList"})
	public String continentList(Model model,
            @RequestParam(value = "continentNo", required = false, defaultValue = "0") int continentNo,
            @RequestParam(value = "countryNo", required = false, defaultValue = "0") int countryNo,
            @RequestParam(value = "cityNo", required = false, defaultValue = "0") int cityNo) {
			model.addAttribute("continentList", continentMapper.selectContinentList());
			
			// 대륙 번호가 0이 아닐 때만 나라 목록 조회
			if (continentNo != 0) {
			List<Map<String, Object>> countryList = continentMapper.selectCountryList(continentNo);
			model.addAttribute("countryList", countryList);
			}
			
			// 나라 번호가 0이 아닐 때만 도시 목록 조회
			if (countryNo != 0) {
			List<Map<String, Object>> cityList = continentMapper.selectCityList(countryNo);
			model.addAttribute("cityList", cityList);
			}
			
			// 선택된 번호를 모델에 추가
			model.addAttribute("selectedContinent", continentNo);
			model.addAttribute("selectedCountry", countryNo);
			model.addAttribute("selectedCity", cityNo);
			
			return "continentList";
			}

}
