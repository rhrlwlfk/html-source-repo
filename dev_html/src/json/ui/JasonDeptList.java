package json.ui;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

public class JasonDeptList {
	public List<Map<String,Object>> getDeptList() {
		List<Map<String,Object>> deptList = new ArrayList<>();
		Map<String,Object> rmap = new HashMap<>();
		rmap.put("rno", 1);
		rmap.put("deptno", 10);
		rmap.put("dname", "총무부");
		rmap.put("loc", "인천");
		deptList.add(rmap);
		 rmap = new HashMap<>();
			rmap.put("rno", 2);
			rmap.put("deptno", 20);
			rmap.put("dname", "영업부");
			rmap.put("loc", "서울");
			deptList.add(rmap);
		rmap = new HashMap<>();
			rmap.put("rno", 3);
			rmap.put("deptno", 30);
			rmap.put("dname", "개발부");
			rmap.put("loc", "제주도");
			deptList.add(rmap);
		return deptList;
	}
	public static void main(String[] args) {
		JasonDeptList jdl = new JasonDeptList();
		List<Map<String,Object>> deptList = jdl.getDeptList();
		Gson g =new Gson();
		String temp = g.toJson(deptList); //gson으로 바꿔서 deptlist를 temp에다가 넣는다 sysout에 출력하려면 String타입안에 넣어야하니
		System.out.println(temp);
	}

}
