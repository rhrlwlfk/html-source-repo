package ajax.pizza;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class CustomerInfo {
	public static void main(String[] args) {
		//자바에서 json을 꺼내야 한다.	
		// rMap = new HashMap<>(); 한번씩 객체생성해줘야됨 새로운게 나올려면
		List<Map<String,Object>> cusList = new ArrayList<>();
		Map<String,Object> rMap = new HashMap<>();
		rMap.put("mem_name","이순신");
		rMap.put("mem_addr","서울시 마포구 공덕동");
		rMap.put("mem_tel","0225559990");
		cusList.add(rMap);
		rMap = new HashMap<>();
		rMap.put("mem_name","김유신");
		rMap.put("mem_addr","서울시 영등포구 당산동");
		rMap.put("mem_tel","0225559991");
		cusList.add(rMap);
		rMap = new HashMap<>();
		rMap.put("mem_name","강감찬");
		rMap.put("mem_addr","서울시 금천구 가산동");
		rMap.put("mem_tel","0225559992");
		cusList.add(rMap);
		Gson g = new GsonBuilder().setPrettyPrinting().create();
		String json = g.toJson(cusList);
		System.out.println(json);
	}
}
