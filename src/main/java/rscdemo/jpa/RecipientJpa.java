package rscdemo.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.Recipient;

import java.util.Date;
import java.util.List;


public interface RecipientJpa extends JpaRepository<Recipient,Long> {
    @Query("select r from rscdemo.pojo.Recipient as r where remailcustomer.maid = ?1")
    public Page<Recipient> getRecipientToma(Long maid, Pageable pageable);


    @Query("select r from rscdemo.pojo.Recipient as r where repost.poid = ?1")
    public Page<Recipient> getRecipientTopo(Long poid, Pageable pageable);

    @Query("select r from rscdemo.pojo.Recipient as r where reid = ?1")
    public Recipient getRecipientById(Long reid);

    @Query("select r.restate.stid from rscdemo.pojo.Recipient as r where repost.poid = ?1")
    public List<Short> GetStateIdByPoid(Long poid);

    @Query("select r from rscdemo.pojo.Recipient as r")
    public Page<Recipient> getAllRecipient(Pageable pageable);

    @Query("select COUNT(r.restate.stid),r.restate.stname,r.restate.stid from rscdemo.pojo.Recipient as r where r.repost.poid = ?1 AND (recreaterdate between ?2 and  ?3) group by r.restate.stid")
    public List<Object[]> getPostReQK(Long poid, Date start,Date end);

    @Query("select r from rscdemo.pojo.Recipient as r where r.repost.poid = ?1 AND recreaterdate between ?2 and  ?3")
    public List<Recipient> getPostRecipient(Long poid, Date start,Date end);
}
