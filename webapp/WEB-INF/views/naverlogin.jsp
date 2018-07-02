<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.simple.JSONObject, org.json.simple.parser.JSONParser" %>

<link rel="icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<%
	String url = "https://nid.naver.com/oauth2.0/token"; //서버에 액세스 토큰을 요청하는 경로
	String grant_type = "authorization_code"; //1) 발급:'authorization_code'	2) 갱신:'refresh_token'		3) 삭제: 'delete'
	String client_id = "lIeESu0jf8vwL6PkjnoI";
	String client_secret = "ECAb3FilRy";
			
	String code = request.getParameter("code");
	String state = request.getParameter("state");
	
	url += "?grant_type=" + grant_type + "&client_id=" + client_id;
	url += "&client_secret=" + client_secret;
	url += "&code=" + code + "&state=" + state;
	
	String accessToken = getAccessToken(url);
	
	//URL의 목적
	//1. 사용자가 입력한 URL이 맞는지 검사
	//잘못되면 MalformedURLException 발생
	//2. InputStream을 만들어냄 (get만 가능)
	//3. URL Connection을 사용 가능 (RW 가능, get/set 모두 가능)
	
	accessToken = myParser(accessToken, "access_token"); //액세스 토큰이 넘어와야 로그인이 성공했다는 의미
	
 	String jsonProfile = getProfile(accessToken);
	
 	JSONParser parser = new JSONParser();
	JSONObject obj = (JSONObject)parser.parse(jsonProfile);
	obj = (JSONObject)obj.get("response");

	String email = (String)obj.get("email");
	
	//System.out.println("naverLogin : " + email);

	session.setAttribute("email", email);
	
	//response.sendRedirect("/PCos/loginComplete");
%>


<%!
	private String getProfile(String accessToken) throws Exception {
		URL url = new URL("https://openapi.naver.com/v1/nid/me");
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod("GET");
		String header = "Bearer " + accessToken; //반드시 Bearer 다음에 한 칸 공백!!
		conn.setRequestProperty("Authorization", header); //setRequestProperty: header 설정
		
		int resCode = conn.getResponseCode();
		BufferedReader br = null;
		
		if(resCode == 200) { //요청한 URL이 맞다면
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		}
		
		String result = "";
		String line = "";
		while((line = br.readLine()) != null) {
			result += line;
		}
		br.close();
		
		return result;
	}
	
	private String myParser(String data, String key) throws Exception {
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(data); //object -> JSONObject 형변환 (Map 타입)
		return (String)obj.get(key);
	}
	
	private String getAccessToken(String requestUrl) throws Exception {
		URL url = new URL(requestUrl);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection(); //URL Connection을 만들어냄, getter/setter를 만들기 위해 생성하는 것
		conn.setRequestMethod("GET");
		
		int resCode = conn.getResponseCode(); //200, 404, 500 등
		BufferedReader br = null;
		
		if(resCode == 200) { //요청한 URL이 맞다면
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		}
		
		String result = "";
		String line = "";
		while((line = br.readLine()) != null) {
			result += line;
		}
		br.close();
		
		return result;
	}
%>
<script>
	$(function() {
		$('#email').val("<%= session.getAttribute("email") %>");
		
		goToLogin();
	});
	
	function goToLogin() {
		var form = document.getElementById('goToLogin');

		form.method = "POST";
		form.action = "/PCos/loginComplete";
		form.submit();
	}
</script>

<body>
	<form id='goToLogin'>
		<input type='hidden' id='email' name='email' />
	</form>
</body>