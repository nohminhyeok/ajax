package com.example.ajax.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ContinentMapper {
	List<Map<String, Object>> selectContinentList();
	
	List<Map<String, Object>> selectCountryList(@Param("continentNo") int continentNo);
	
	List<Map<String, Object>> selectCityList(@Param("countryNo") int countryNo);
}
