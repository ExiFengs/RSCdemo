package rscdemo.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.Management;


public interface ManagementJpa extends JpaRepository<Management,Long> {
    @Query("select m from rscdemo.pojo.Management as m where maloginname = ?1 and mapassword = ?2")
    public Management findManagement(String maloginname,String mapassword);
}
