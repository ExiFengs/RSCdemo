package rscdemo.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.Sentpieces;

import java.util.Date;
import java.util.List;


public interface SentpiecesJpa extends JpaRepository<Sentpieces,Long>{
    @Query("select s from rscdemo.pojo.Sentpieces as s where semailcustomername = ?1")
    public Page<Sentpieces> getSemailcustomerToma(String semailcustomername, Pageable pageable);

    @Query("select s from rscdemo.pojo.Sentpieces as s where sepost.poid = ?1")
    public Page<Sentpieces> getSentpiecesToPost(Long poid,Pageable pageable);

    @Query("select s from rscdemo.pojo.Sentpieces as s")
    public Page<Sentpieces> getAllSentpieces(Pageable pageable);


    @Query("select s from rscdemo.pojo.Sentpieces as s where seid = ?1")
    public Sentpieces getSentpiecesToId(Long id);

    @Query("select s.sestate.stid from rscdemo.pojo.Sentpieces as s where sepost.poid = ?1")
    public List<Short> getStateIdByPoid(Long poid);

    @Query("select COUNT(s.sestate.stid),s.sestate.stname,s.sestate.stid from rscdemo.pojo.Sentpieces as s where s.sepost.poid = ?1 AND (secreatedate between ?2 and  ?3) group by s.sestate.stid")
    public List<Object[]> getPostSeQK(Long poid, Date start, Date end);

    @Query("select s from rscdemo.pojo.Sentpieces as s where s.sepost.poid = ?1 AND secreatedate between ?2 and  ?3")
    public List<Sentpieces> getSentpiecesTopoid(Long poid, Date start, Date end);
}
