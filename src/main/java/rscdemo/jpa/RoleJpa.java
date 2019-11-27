package rscdemo.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.Role;


public interface RoleJpa extends JpaRepository<Role,Short> {
    @Query("select r from rscdemo.pojo.Role as r where roid = ?1")
    public Role getRoleById(Short roid);
}
