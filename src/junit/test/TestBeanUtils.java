package junit.test;

import org.springframework.beans.BeanUtils;

public class TestBeanUtils {
	
	
	public static void main(String args[]){
//		People people = new People();
//		people.setAge(1);
//		people.setEmail("23423");
//		
//		
//		Person person = new Person();
//		person.setName("hyl");
//		
//		
//		CopyOfPeople copyOfPeople = new CopyOfPeople();
//		BeanUtils.copyProperties(person, people);         
//		System.out.println(people.getEmail());
//		BeanUtils.copyProperties(people, person);
//		BeanUtils.copyProperties(person, copyOfPeople);
//		System.out.println(person.getAge()+"----"+person.getName());
//		
//		System.out.println(copyOfPeople.getEmail());
		String arch = System.getProperty("sun.arch.data.model");
		System.out.println(arch);
	}

}
