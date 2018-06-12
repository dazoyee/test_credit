package sbpayment.jp.intro;

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
	
	@PostMapping("/test_credit_select1")
	public String test_credit_select1(int creditcard_id[], RedirectAttributes attr) {
		for (int i=0; i<creditcard_id.length; i++ ) {
//		attr.addAttribute("service_id", service_id);
			jdbc.update("insert into creditcard_service_user (creditcard_id) values(?);", creditcard_id[i]);
		}
		return "redirect:/test_credit_select1";
	}
	
	
	@PostMapping("/test_credit_result")
	public String test_credit_result(int creditcard_id[], int service_id[], RedirectAttributes attr) {
		for (int j=0; j<creditcard_id.length; j++ ) {
		for (int i=0; i<service_id.length; i++ ) {
//		attr.addAttribute("service_id", service_id);
			jdbc.update("insert into creditcard_service_user (creditcard_id,service_id) values(?,?);", creditcard_id[j],service_id[i]);
		}}
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

	