package rscdemo.controller.MainCustomer;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import rscdemo.pojo.*;
import rscdemo.service.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/user")
public class MianCustomerController {
    @Resource
    MailcustomerService mailcustomerService;

    @Resource
    RoleService roleService;

    @Resource
    SentpiecesService sentpiecesService;

    @Resource
    RecipientService recipientService;

    @Resource
    WorkingareaService workingareaService;

    @Resource
    PostService postService;

    @Resource
    StateService stateService;

    @GetMapping("/index")
    public String indexto() {
        return "MC/MainCustomerlogin";
    }

    @PostMapping("/login")
    public String loginto(String loginname, String password, HttpServletRequest httpServletRequest) {
        Mailcustomer mailcustomer = null;
        try {
            mailcustomer = mailcustomerService.getMailCustomer(loginname, password);
            httpServletRequest.setAttribute("info", "登录成功！");
            httpServletRequest.getSession().setAttribute("mailcustomer", mailcustomer);
            Sort sort = new Sort(Sort.Direction.DESC, "seid");
            Pageable pageable = PageRequest.of(0, 10, sort);
            Page<Sentpieces> sentpieces = sentpiecesService.findToMailCustormer(mailcustomer.getManame(), pageable);
            List<Sentpieces> sentpieces1 = sentpieces.getContent();
            isoverdue(sentpieces1);
            httpServletRequest.setAttribute("sentpieces", sentpieces1);
            return "MC/Home";
        } catch (NullPointerException e) {
            System.out.println("登录出错.................");
            return "MC/errorlogin";
        }
    }

    @GetMapping("/pagesent/{page}")
    public String getPageSent(@PathVariable int page, HttpServletRequest httpServletRequest) {
        Mailcustomer mailcustomer = (Mailcustomer) httpServletRequest.getSession().getAttribute("mailcustomer");
        Sort sort = new Sort(Sort.Direction.DESC, "seid");
        Pageable pageable = PageRequest.of(page - 1, 10, sort);
        Page<Sentpieces> sentpieces = sentpiecesService.findToMailCustormer(mailcustomer.getManame(), pageable);
        List<Sentpieces> sentpieces1 = sentpieces.getContent();
        isoverdue(sentpieces1);
        httpServletRequest.setAttribute("sentpieces", sentpieces1);
        return "MC/Home";
    }

    @GetMapping("/town/{area}")
    public
    @ResponseBody
    List<Workingarea> towns(@PathVariable String area) {
        return workingareaService.findWoidAndWotown(area);
    }


    @PostMapping("/register")
    public String registerto(String loginname, String password, HttpServletRequest request) {
        Mailcustomer mailcustomer = mailcustomerService.saveMailCustomer(loginname, password);
        request.getSession().setAttribute("mailcustomer", mailcustomer);
        request.setAttribute("info", "注册成功！");
        return "MC/Home";
    }

    @GetMapping("/mail/{page}")
    public String getmail(@PathVariable int page, HttpServletRequest httpServletRequest) {
        List<String> woareas = woareas = workingareaService.findToWoarea();
//        System.out.println(woareas.toString());
        httpServletRequest.setAttribute("woareas", woareas);
        Mailcustomer mailcustomer = (Mailcustomer) httpServletRequest.getSession().getAttribute("mailcustomer");
        //排序，选择配送员
        Sort sort = new Sort(Sort.Direction.DESC, "reid");
        Pageable pageable = PageRequest.of(page - 1, 10, sort);
        Page<Recipient> recipients = recipientService.findRecipientToMailCustormer(mailcustomer.getMaid(), pageable);
        List<Recipient> recipients1 = recipients.getContent();
        isreoverdue(recipients1);
        httpServletRequest.setAttribute("recipients", recipients1);
        return "MC/Mail";
    }


    @GetMapping("/info")
    public String getinfo(HttpServletRequest request) {
        List<String> woareas = woareas = workingareaService.findToWoarea();
        System.out.println(woareas.toString());
        request.setAttribute("woareas", woareas);
        List<Workingarea> workingareas = workingareaService.findAllWorkingArea();
        request.setAttribute("workingareas", workingareas);
        return "MC/Info";
    }

    @PostMapping("/upinfo")
    public
    @ResponseBody
    String resuleinfo(HttpServletRequest request, String username, String phone, Long woid, String address) {
        Mailcustomer mailcustomer = (Mailcustomer) request.getSession().getAttribute("mailcustomer");
        mailcustomer.setManame(username);
        mailcustomer.setMaadress(address);
        mailcustomer.setMaworkingarea(workingareaService.findworkingareaById(woid));
        mailcustomer.setMaphone(phone);
        if (mailcustomer.getMarole().getRoid() == 1) {
            mailcustomer.setMarole(roleService.findRoleById((short) 2));
        }
        mailcustomerService.savemailcustomer(mailcustomer);
        request.getSession().setAttribute("mailcustomer", mailcustomer);
        return "更改成功！";
    }

    @PostMapping("/upsend")
    public
    @ResponseBody
    String addsend(String usname, String usphone, Long woid, HttpServletRequest request, String readress) {
        Mailcustomer mailcustomer = (Mailcustomer) request.getSession().getAttribute("mailcustomer");
        Workingarea workingarea = workingareaService.findworkingareaById(woid);
        Recipient recipient = new Recipient();
        recipient.setRestateadress(readress);
        recipient.setRemailcustomer(mailcustomer);
        recipient.setRename(usname);
        recipient.setRecreaterdate(new Date());
        recipient.setRephone(usphone);
        recipient.setReendadress(workingarea);
        List<Post> posts = postService.findAppropriatePost(workingarea);
        if (posts.isEmpty()){
            return "不好意思，该区域暂时无邮差工作！详情请联系客服10086";
        }
        Post appost = posts.get(0);
        Integer load = appost.getPoworkload();
        appost.setPoworkload(load + 1);
        recipient.setRepost(appost);
        recipient.setRestate(stateService.findStateById((short) 1));
        postService.update(appost);
        recipientService.saveRecipient(recipient);
        return "添加成功！";
    }


    public void isoverdue(List<Sentpieces> sentpieces) {
        for (int i = 0; i < sentpieces.size(); i++) {
            if (sentpieces.get(i).getSestate().getStid() == (short)1||sentpieces.get(i).getSestate().getStid() == (short)2) {
                Date date = sentpieces.get(i).getSecreatedate();
                if (date.getTime() + 259200000 < new Date().getTime()) {
                    sentpieces.get(i).setSestate(stateService.findStateById((short) 0));
                    Post post = sentpieces.get(i).getSepost();
                    Integer integer = post.getPoworkload();
                    post.setPoworkload(integer-1);
//                    System.out.println(post.getPoworkload()+"-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-");
                    postService.update(post);
                    sentpiecesService.savesentpieces(sentpieces.get(i));
                }
            }
        }
    }

    public void isreoverdue(List<Recipient> recipients) {
        for (int i = 0; i < recipients.size(); i++) {
            if (recipients.get(i).getRestate().getStid() == (short)1||recipients.get(i).getRestate().getStid() == (short)2) {
                Date date = recipients.get(i).getRecreaterdate();
                if (date.getTime() + 259200000 < new Date().getTime()) {
                    recipients.get(i).setRestate(stateService.findStateById((short) 0));
                    Post post = recipients.get(i).getRepost();
                    Integer integer = post.getPoworkload();
                    post.setPoworkload(integer-1);
//                    System.out.println(post.getPoworkload()+"-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-");
                    postService.update(post);
                    recipientService.saveRecipient(recipients.get(i));
                }
            }
        }
    }
}
