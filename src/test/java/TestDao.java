import com.atom.crud.bean.Department;
import com.atom.crud.dao.DepartmentMapper;
import com.atom.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:ApplicationContext.xml"})
public class TestDao {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void test01(){
//         Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
//        System.out.println(employee.getEmpName()+"===="+employee.getDepartment().getDepName());
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
          DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);

//        int x=100+(int)(Math.random()*999);
//        Integer y = x;
//        String emailPrefix = y.toString();
//        for (int i=0 ; i<1000 ; i++){
//            String name = UUID.randomUUID().toString().substring(0,5);
//
//            mapper.insertSelective(new Employee(null,name,"M",emailPrefix+"@qq.com","1"));
//
//        }
        List<Department> department = departmentMapper.selectByExample(null);
        for (Department item : department){
            System.out.println(item.getDepName());
        }
    }
}
