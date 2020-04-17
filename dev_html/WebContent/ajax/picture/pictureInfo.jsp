<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//화면이 없어도 단위테스트가 가능해야함.
//디자이너가 없어도 내페이지를 아직 못 만들었어다고 해도 나는 코딩 할 수 있다.
//클래스 조꺠기
//192.168.0.254:8000/dev_html/ajax/pictureInfo.jsp?id=picture2.jpg
	String img = request.getParameter("id");
	//out.print("img:" + img);
	String imgs[] = {"picture1.jpg","picture2.jpg"
					,"picture3.jpg","picture4.jpg"};
	String cimg = null;
	for(int i=0;i<imgs.length;i++) {
		//equals차이점 
		if(img.equals(imgs[i])) {
			cimg = imgs[i];
		}
	}
%>
<img src="./<% out.print(cimg);%> "cimg width="400px" height="270px" border="1">