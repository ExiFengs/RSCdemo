package rscdemo.service;

import org.springframework.stereotype.Service;
import rscdemo.jpa.ManagementJpa;
import rscdemo.pojo.Management;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


@Service
public class ManagementService {

    @Resource
    ManagementJpa managementJpa;

    public int getMangement(String loginame, String password, HttpServletRequest request){
        Management management = managementJpa.findManagement(loginame,password);
        request.getSession().setAttribute("admin",management);
        if (management==null){
            return 0;
        }
        return 1;
    }
}
