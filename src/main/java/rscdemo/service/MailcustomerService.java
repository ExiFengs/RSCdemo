package rscdemo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import rscdemo.jpa.MailcustomerJpa;
import rscdemo.pojo.Mailcustomer;
import rscdemo.pojo.Role;

import java.util.HashSet;
import java.util.Set;


@Service
public class MailcustomerService {
    @Autowired
    MailcustomerJpa mailcustomerJpa;

    @Autowired
    RoleService roleService;

    public Mailcustomer getMailCustomer(String loginname,String password){
        return mailcustomerJpa.findMailCustomer(loginname,password);
    }

    public Mailcustomer savemailcustomer(Mailcustomer mailcustomer){
        return mailcustomerJpa.save(mailcustomer);
    }

    public Mailcustomer saveMailCustomer(String loginame,String password){
        Mailcustomer mailcustomer = new Mailcustomer();
        mailcustomer.setMaloginname(loginame);
        mailcustomer.setMapassword(password);
        Set<Mailcustomer> mailcustomers = new HashSet<>();
        Role role = roleService.findRoleById((short)1);
        mailcustomer.setMarole(role);
        mailcustomers.add(mailcustomer);
        return mailcustomerJpa.save(mailcustomer);
    }

    public Page<Mailcustomer> findallmailcustomer(Pageable pageable){
        return mailcustomerJpa.getAllMailcustomer(pageable);
    }

    public Mailcustomer findMailToId(Long maid){
        return mailcustomerJpa.getMailById(maid);
    }
}
