<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 상세 열람</title>
</head>
<body>
    <h1>회원 정보 상세 열람</h1>
	
	// mysql database 연결
	<%@ include file="post_dbconn.jsp" %>
	
    <%
		// JDBC 드라이버 연결
	    Class.forName("com.mysql.jdbc.Driver");
		
        Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
        
        // 받아오는 문자열의 인코딩 방식 결정
        request.setCharacterEncoding("UTF-8");
        
        // 파라미터를 통해 전해진 게시글 번호를 받아와, num 변수에 저장
        String student_id = request.getParameter("student_id");
        
        // MySQL로 전송하기 위한 쿼리문인 insertQuery 문자열 선언 (읽어온 게시글 번호를 통해, 불러올 게시글을 결정함)
        String insertQuery = "SELECT * FROM student_db.students WHERE student_id=" + student_id;
        
        // SQL 쿼리문을 실행 (MySQL로 전송)하기 위한 객체 선언
        PreparedStatement psmt = connection.prepareStatement(insertQuery);
        
        // 조회된 결과물들을 저장하기 위한 ResultSet 객체 선언
        ResultSet result = psmt.executeQuery(); %>
        
        <table border="1">
            <%
            // 받아온 정보가 있을때
            while(result.next())
            {%>
            	<tr>
            	    <!-- 번호 <td> 옆에 DB에서 받아온 student_id 칼럼값 삽입 -->
            	    <td>번호</td>
            	    <td><%=result.getInt("student_id") %></td>
            	</tr>
            	<tr>
            	    <!-- 생성 <td> 옆에 DB에서 받아온 registration_date 칼럼값 삽입 -->
            	    <td>생성일</td>
            	    <td><%=result.getTimestamp("registration_date") %></td>
            	</tr>
            	<tr>
            	    <!-- 이름 <td> 옆에 DB에서 받아온 full_name 칼럼값 삽입 -->
            	    <td>이름</td>
            	    <td><%=result.getString("full_name") %></td>
            	</tr>
            	<tr>
            	    <!-- 전화 번호 <td> 옆에 DB에서 받아온 phone_number 칼럼값 삽입 -->
            	    <td>전화 번호</td>
            	    <td><%=result.getString("phone_number") %></td>
            	</tr>
            	<tr>
            	    <!-- 이메일 <td> 옆에 DB에서 받아온 email 칼럼값 삽입 -->
            	    <td>이메일</td>
            	    <td><%=result.getString("email") %></td>
            	</tr>
            	<tr>
            	    <td colspan="2">
            	        <!-- 목록으로 버튼을 누르면 post_list.jsp로 연결됨 -->
            	        <button type=button onclick="location.href='post_list.jsp'">목록으로</button>
            	    </td>
            	</tr>
            	<%            	
            }%>
        </table>
        <%
    }
    catch (Exception ex)
    {
        out.println("오류가 발생했습니다. 오류 메시지 : " + ex.getMessage());
    }%>

</body>
</html>