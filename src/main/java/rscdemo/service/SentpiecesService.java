package rscdemo.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import rscdemo.jpa.SentpiecesJpa;
import rscdemo.pojo.Sentpieces;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;


@Service
public class SentpiecesService {
    @Resource
    SentpiecesJpa sentpiecesJpa;

    public Page<Sentpieces> findToMailCustormer(String semailcustomername, Pageable pageable){
        return sentpiecesJpa.getSemailcustomerToma(semailcustomername,pageable);
    }

    public Page<Sentpieces> getToPost(Long poid,Pageable pageable){
        return sentpiecesJpa.getSentpiecesToPost(poid,pageable);
    }

    public Page<Sentpieces> findAllSentpieces(Pageable pageable){
        return sentpiecesJpa.getAllSentpieces(pageable);
    }

    public Sentpieces savesentpieces(Sentpieces sentpieces){
        return sentpiecesJpa.save(sentpieces);
    }

    public Sentpieces findSentipiecesById(Long id){
        return sentpiecesJpa.getSentpiecesToId(id);
    }

    public List<Short> GetStateIdByPoidToSe(Long poid){
        return sentpiecesJpa.getStateIdByPoid(poid);
    }

    public List<Object[]> findPostSeQK(Long poid, Date start,Date end){
        return sentpiecesJpa.getPostSeQK(poid,start,end);
    }

    public List<Sentpieces> findSentpiecesTopoid(Long poid,Date start,Date end){
        return sentpiecesJpa.getSentpiecesTopoid(poid,start,end);
    }



}
