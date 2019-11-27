package rscdemo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rscdemo.jpa.RoleJpa;
import rscdemo.pojo.Role;


@Service
public class RoleService {
    @Autowired
    RoleJpa roleJpa;

    public Role findRoleById(Short roid){
        return roleJpa.getRoleById(roid);
    }
}
