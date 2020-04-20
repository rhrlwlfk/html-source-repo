<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
//디클러레이션 - 전역변수이다.
//싱글톤으로 관리(서블릿 - newsData_jsp.java => HttpServlet - 이객체는 계속 유지됨 - 새로고침을 당해도.)
	int x= 1;//전역변수
	public String newsList(String news[]){
		//자바성능튜닝팀 지적시험 - 삼성sds - 지방공개정보시스템
		StringBuilder sb = new StringBuilder();
		sb.append("<table width='500px' border='1'>");
		sb.append("<tr><td>" +news[0] +" > " +news[1]+"</td></tr>");
		sb.append("</table>");
		return sb.toString();
	}
%>
<%
	String news1[] = {"연합뉴스","오상헬스케어 코로나 진단키트, 美 FDA 첫 긴급사용승인"};
	String news2[] = {"연합뉴스","술먹고 객기 부린 죄···벤틀리 걷어찬 20대 수천만원 물을 판"};
	String news3[] = {"연합뉴스","코로나 타격 일본, 아이폰 SE 출시일도 늦췄다"};
	String news4[] = {"연합뉴스","캐나다 시골마을서 총기난사로 13명 사망"};
	String news5[] = {"연합뉴스","뉴욕에선 ‘코로나 탓에 결혼 못한다’는 핑계 안통한다"};
	
	//화면에 내보내 질 코드 담기 
	String datas = "";
	switch(x){
	case 1:
		datas= newsList(news1);
		x++;
		break;
	case 2:
		datas= newsList(news2);
		x++;
		break;
	case 3:
		datas= newsList(news3);
		x++;
		break;
	case 4:
		datas= newsList(news4);
		x++;
		break;
	case 5:
		datas= newsList(news5);
		x=1;
		break;
	}
	out.clear();
	out.print(datas);
%>