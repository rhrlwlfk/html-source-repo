package project_resturant;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class RestaurantDatTest {
	RestaurantDao rdao = new RestaurantDao();
	@Test
	void test() {
		assertEquals(7,rdao.procRestList());
	}
}
