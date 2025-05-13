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
		<select id="continent" name="continent">
			<option value="">:::대륙선택:::</option>
			<c:forEach var="continent" items="${cntnntList}">
				<option value="${continent.continentNo}">${continent.continentName}</option>
			</c:forEach>
		</select>
		
		<select id="country" name="country">
			<option value="">:::나라선택:::</option>
		</select>
		
		<select id="city" name="city">
			<option value="">:::도시선택:::</option>
		</select>
	</form>
	
	<script>
		/*
			fetch("API 주소", {method : "post"})
			.then((response) => {return response.json()})
			.then((data) => {console.log(data)})
			.catch((error) => {console.log(error)})
		*/
		document.querySelector('#continent').addEventListener('change', function(){
		    if(this.value == ''){
		        alert('대륙을 선택하세요'); // 대륙 선택이 안 된 경우 경고
		        return;
		    }
		    // 선택된 대륙의 나라 목록을 가져와서 나라 선택에 보냄 (append 확장) (fetch or Ajax -> 비동기요청)
		    fetch('/cntList/' + this.value)
		    .then(function(response) { 
		    	return response.json(); 
		    })
		    .then(function(result) {
				document.querySelector('#country').innerHTML = '<option value="">:::나라선택:::</option>'; // 나라 선택 기본값 설정
		        result.forEach(function(e) {
		            let option = document.createElement('option'); // 새로운 <option> 엘리먼트 생성
		            option.setAttribute('value', e.countryNo); // 국가 번호를 value로 설정
		            option.textContent = e.countryName; // ex) <option value="e.countryNo"> e.countryName </option>
		            document.querySelector('#country').append(option); // <select> 요소에 추가
		        });
		    })
		    .catch(function(error) {
				console.log('Error fetching country list:', error); // 오류 발생 시 로그 출력
			});
		});

		document.querySelector('#country').addEventListener('change', function(){
			if(this.value == ''){
				alert('나라를 선택하세요'); // 나라 선택이 안 된 경우 경고
				return;
			}
			// 선택된 나라의 도시 목록을 가져와서 도시 선택에 보냄 (append 확장) (비동기요청)
			fetch('/cityList/' + this.value)
			.then(function(res) { 
				return res.json(); 
			})
			.then(function(result) {
				document.querySelector('#city').innerHTML = '<option value="">:::도시선택:::</option>'; // 도시 선택 기본값 설정
				result.forEach(function(e){
					let option = document.createElement('option'); // 새로운 <option> 엘리먼트 생성
					option.setAttribute('value', e.cityNo); // 도시 번호를 value로 설정
					option.textContent = e.cityName; // ex) <option value="e.cityNo"> e.cityName </option>
					document.querySelector('#city').append(option); // <select> 요소에 추가
				});
			})
			.catch(function(error) {
				console.log('Error fetching city list:', error); // 오류 발생 시 로그 출력
			});
		});
	</script>
</body>
</html>
