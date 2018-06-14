package sbpayment.jp.intro;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MainController {

	@Autowired
	private JdbcTemplate jdbc;

	@GetMapping("/test_credit_title")
	public String test_credit_title() {
	return "test_credit_title";
	}	
	
	@GetMapping("/test_credit_select1")
	public String test_credit_select1(Model model) {
	return "test_credit_select1";
	}
	
	@GetMapping("/test_credit_result")
	public String test_credit_result() {
	return "test_credit_result";
	}
	
	@PostMapping("/test_credit_result")
	public String test_credit_result(int service_id[], RedirectAttributes attr) {
		jdbc.update("DELETE FROM creditcard_service_user WHERE creditcard_id = 99");
		for (int i=0; i<service_id.length; i++) {
			jdbc.update("INSERT INTO creditcard_service_user (creditcard_id,service_id,score) values(99,?,1);", service_id[i]);
		}

		for(int i=0; i<5; i++) {
		Map<String,Object> sum = jdbc.queryForList("SELECT creditcard_id,COUNT(service_id) FROM creditcard_service GROUP BY creditcard_id").get(i);
		System.out.println(sum);
		double norm = Math.sqrt(Double.valueOf(sum.get("COUNT(service_id)").toString()));
		System.out.println(norm);
		double nscore = 1/norm;
		System.out.println(nscore);
		System.out.println();
		
		}
		
/*		Map<String,Object> sum = jdbc.queryForMap("SELECT COUNT(service_id) FROM creditcard_service WHERE creditcard_id = 1");
		double norm = Math.sqrt(Double.valueOf(sum.get("COUNT(service_id)").toString()));
*/		
//		List<Map<String,Object>> sums = new ArrayList<Map<String,Object>>();
//		Map<String, Object> sum;
//		for(int i=0; i<sums.size(); i++) {
//			Map<String, Object> sum = sums.get(i);
	//		List<Map<String,Object>> sums = jdbc.queryForList("SELECT COUNT(service_id) FROM creditcard_service GROUP BY creditcard_id");
//			for(Map<String, Object> sum : sums)
//			double norm = Math.sqrt(Double.valueOf(sums.get("COUNT(service_id)").toString()));
			
			
//		}
		return "redirect:/test_credit_result";
	}
}


	/*
	@GetMapping("/form")
	public String sample(String name, int age, Model model) {

	model.addAttribute("name", name);
	model.addAttribute("age", age);
	
	//DB挿入
	jdbc.update("insert into DBTest (name,age) values(?,?);", name,age);
	
//	model.addAttribute("name1",jdbc.queryForList("SELECT * FROM DBTest").get(1));
//	model.addAttribute("name2",jdbc.queryForList("SELECT * FROM DBTest").get(1).get("name"));
	model.addAttribute("DBTests",jdbc.queryForList("SELECT * FROM DBTest"));
	
	//DB更新
//	jdbc.update("UPDATE DBTest SET name = ?,age = ?", name,age);
//    Map<String, Object> DBTest = jdbc.queryForList("SELECT * FROM DBTest where name = ?", name).get(0);
	
	return "hello";
	}
	*/

	