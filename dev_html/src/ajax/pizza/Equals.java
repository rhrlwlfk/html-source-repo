package ajax.pizza;

public class Equals {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String s = "안녕";
		String s1 = new String("안녕");
		//s ==  s1같니 이거는 s가 값이아니라 안녕 이 값이다 ///그래서 주소번지가 같니?? 아니다 
		//s.equals(s1) 같니? 그 주소번지가 가리키는 값이 같은거야 
		if(s == s1) {
			System.out.println("같다");
		}
		else {
			System.out.println("다르다");
		}
		if(s.equals(s1)) {
			System.out.println("같다");
		}
		else {
			System.out.println("다르다");
		}

	}

}
