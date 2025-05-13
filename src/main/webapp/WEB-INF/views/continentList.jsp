<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="form1" action="/continentList" method="get">
		<select id="continentList" name="continentNo" onchange="this.form.submit()">
			<option value="0">:::대륙선택:::</option>
			<c:forEach var="continent" items="${continentList}">
				<option value="${continent.continentNo}" ${continent.continentNo == selectedContinent ? 'selected' : ''}>
					${continent.continentName}
				</option>
			</c:forEach>
		</select>

		<select id="countryList" name="countryNo" onchange="this.form.submit()">
			<option value="0">:::나라선택:::</option>
			<c:forEach var="country" items="${countryList}">
				<option value="${country.countryNo}" ${country.countryNo == selectedCountry ? 'selected' : ''}>
					${country.countryName}
				</option>
			</c:forEach>
		</select>

		<select id="cityList" name="cityNo">
			<option value="0">:::도시선택:::</option>
			<c:forEach var="city" items="${cityList}">
				<option value="${city.cityNo}" ${city.cityNo == selectedCity ? 'selected' : ''}>
					${city.cityName}
				</option>
			</c:forEach>
		</select>
	</form>
	
	<script>
		document.querySelector('#continent').addEventListener('change', function(){
			if(this.value == ''){
				alert('대륙을 선택하세요');
				return;
			}
			document.querySelector('#form1').submit();
		})

		document.querySelector('#country').addEventListener('change', function(){
			if(this.value == ''){
				alert('나라를 선택하세요');
				return;
			}
			document.querySelector('#form1').submit();
		})
	</script>
</body>
</html>