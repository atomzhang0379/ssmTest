import com.atom.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试请求功能
 *
 *
 */



@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:ApplicationContext.xml", "classpath:dispatchServlet-servlet.xml"})
public class MVCTest {

    @Autowired
    WebApplicationContext context;

    MockMvc mockMvc;



//    初始化mockMvc
    @Before
    public  void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage(){
        try {
//            模拟请求
           MvcResult result =  mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();

            MockHttpServletRequest request = result.getRequest();
            PageInfo attribute = (PageInfo) request.getAttribute("pageInfo");
            System.out.println("当前页码"+attribute.getPageNum());
            System.out.println( "总页码"+attribute.getPages());
            System.out.println("总记录数"+attribute.getTotal());
            System.out.println("在页面显示的连续页码");
            int[] ints = attribute.getNavigatepageNums();
            for (int item: ints) {
                System.out.print(item);
            }


            List<Employee> list = attribute.getList();
            for (Employee employee : list){
                System.out.println("ID:"+employee.getEmpId()+"姓名："+employee.getEmpName());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
