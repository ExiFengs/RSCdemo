package rscdemo.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.Mailcustomer;


/**
 * 邮客
 */
public interface MailcustomerJpa extends JpaRepository<Mailcustomer,Long>{
    @Query("select m from rscdemo.pojo.Mailcustomer as m where maloginname = ?1 and mapassword = ?2")
    public Mailcustomer findMailCustomer(String pologinname,String popassword);

    @Query("select m from rscdemo.pojo.Mailcustomer as m")
    public Page<Mailcustomer> getAllMailcustomer(Pageable pageable);

    @Query("select m from rscdemo.pojo.Mailcustomer as m where maid = ?1")
    public Mailcustomer getMailById(Long maid);
    
}
