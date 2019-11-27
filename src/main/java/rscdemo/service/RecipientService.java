package rscdemo.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import rscdemo.jpa.RecipientJpa;
import rscdemo.pojo.Recipient;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;


@Service
public class RecipientService {
    @Resource
    RecipientJpa recipientJpa;

    public Page<Recipient> findRecipientToMailCustormer(Long maid, Pageable pageable) {
        return recipientJpa.getRecipientToma(maid, pageable);
    }

    public Page<Recipient> findRecipientToPost(Long poid, Pageable pageable){
        return recipientJpa.getRecipientTopo(poid,pageable);
    }


    public Recipient findRecipientToId(Long reid){
        return recipientJpa.getRecipientById(reid);
    }

    public Recipient saveRecipient(Recipient recipient){
        return recipientJpa.save(recipient);
    }

    public List<Short> findStateByPoidToRe(Long poid){
        return recipientJpa.GetStateIdByPoid(poid);
    }

    public List<Object[]> getPostReQk(Long poid, Date start,Date end){
        return recipientJpa.getPostReQK(poid,start,end);
    }

    public Page<Recipient> findAllRecipient(Pageable pageable){
        return recipientJpa.getAllRecipient(pageable);
    }

    public List<Recipient> findPostRecipient(Long poid, Date start,Date end){
        return recipientJpa.getPostRecipient(poid,start,end);
    }
}
