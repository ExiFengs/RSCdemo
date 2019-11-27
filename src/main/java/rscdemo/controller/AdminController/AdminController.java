package rscdemo.controller.AdminController;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import rscdemo.pojo.*;
import rscdemo.service.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource
    ManagementService managementService;

    @Resource
    MailcustomerService mailcustomerService;

    @Resource
    WorkingareaService workingareaService;

    @Resource
    RoleService roleService;

    @Resource
    PostService postService;

    @Resource
    SentpiecesService sentpiecesService;

    @Resource
    RecipientService recipientService;

    @Resource
    StateService stateService;


    @GetMapping("/index")
    public String Shouye() {
        return "AD/Index";
    }

    @PostMapping("/login")
    public
    @ResponseBody
    int isMangement(String adminname, String adminpassword, HttpServletRequest request) {
//        System.out.println(adminname+"**********************"+adminpassword);
        return managementService.getMangement(adminname, adminpassword, request);
    }

    @GetMapping("/user/{page}")
    public String GetAllMailCustomer(@PathVariable int page, HttpServletRequest request) {
        Sort sort = new Sort(Sort.Direction.DESC, "maid");
        Pageable pageable = PageRequest.of(page - 1, 10, sort);
        Page<Mailcustomer> mailcustomers = mailcustomerService.findallmailcustomer(pageable);
        List<Mailcustomer> mailcustomers1 = mailcustomers.getContent();
        request.setAttribute("alluser", mailcustomers1);
        return "AD/User";
    }

    @PostMapping("/changeuserrole")
    public
    @ResponseBody
    String ChageUserRole(Long maid, Short roleid) {
//        System.out.println(maid+"***************************************"+roleid);
        Mailcustomer mailcustomer = mailcustomerService.findMailToId(maid);
        Role role = roleService.findRoleById(roleid);
        mailcustomer.setMarole(role);
        mailcustomerService.savemailcustomer(mailcustomer);
        return "更改成功！";
    }

    @GetMapping("/work/{page}")
    public String GetOfPost(@PathVariable int page, HttpServletRequest request) {
        List<String> woareas = woareas = workingareaService.findToWoarea();
//        System.out.println(woareas.toString());
        request.setAttribute("woareas", woareas);
        Sort sort = new Sort(Sort.Direction.ASC, "poid");
        Pageable pageable = PageRequest.of(page - 1, 10, sort);
        Page<Post> posts = postService.findAllPost(pageable);
        List<Post> posts1 = posts.getContent();
        List<Integer> postworkload = postService.getPostWorkload();
        List<String> postname = postService.getPostName();
        request.setAttribute("works", posts1);
        request.setAttribute("postworkloads",postworkload);
        request.setAttribute("postnames",postname);
        return "AD/Work";
    }

    @GetMapping("/town/{area}")
    public
    @ResponseBody
    List<Workingarea> towns(@PathVariable String area) {
        return workingareaService.findWoidAndWotown(area);
    }

    @PostMapping("/changepost")
    public
    @ResponseBody
    String Update(Long poid, String popassword, String pophone, Integer work, Long woid) {
        Post post = postService.GetPost(poid);
        post.setPopassword(popassword);
        post.setPophone(pophone);
        Boolean iswork = work == 1 ? true : false;
        post.setPowork(iswork);
        ArrayList<Short> repostid = (ArrayList<Short>) recipientService.findStateByPoidToRe(poid);
        ArrayList<Short> sepostid = (ArrayList<Short>) sentpiecesService.GetStateIdByPoidToSe(poid);
        Workingarea workingarea = workingareaService.findworkingareaById(woid);
        if (workingarea != post.getPoworkarea()) {
            if (repostid.contains(new Short((short) 1)) || repostid.contains(new Short((short) 2)) || sepostid.contains(new Short((short) 1)) || sepostid.contains(new Short((short) 2))) {
                return "该邮差目前在所处区域有正在进行的工作，不可更改！";
            }else {
                post.setPoworkarea(workingarea);
            }
        }
        postService.update(post);
        return "更改成功";
    }

    @PostMapping("/addpost")
    public @ResponseBody String addPost(String postname,String postpassword,String postphone,Long postwotown,Integer postwork){
        Post post = new Post();
        System.out.println(postname+"***"+postpassword+"****"+postphone+"****"+postwork+"*****"+postwotown);
        post.setPophone(postphone);
        post.setPoname(postname);
        post.setPopassword(postpassword);
        post.setPoworkload(0);
        post.setPoworkarea(workingareaService.findworkingareaById(postwotown));
        Boolean work = postwork==1?true:false;
        post.setPowork(work);
        postService.update(post);
        return "添加邮差成功！";
    }

    @GetMapping("Mailing/{page}")
    public String getMailing(@PathVariable int page,HttpServletRequest request){
        Sort sort = new Sort(Sort.Direction.DESC,"reid");
        Pageable pageable = PageRequest.of(page-1,10,sort);
        Page<Recipient> recipients = recipientService.findAllRecipient(pageable);
        List<Recipient> recipients1 = recipients.getContent();
        request.setAttribute("recipientes",recipients1);
        return "AD/Mailing";
    }


    @GetMapping("pie/{page}")
    public String getPie(@PathVariable int page,HttpServletRequest request){
        Sort sort = new Sort(Sort.Direction.DESC,"seid");
        Pageable pageable = PageRequest.of(page-1,10,sort);
        Page<Sentpieces> sentpieces = sentpiecesService.findAllSentpieces(pageable);
        List<Sentpieces> sentpieces1 = sentpieces.getContent();
        List<String> woareas = woareas = workingareaService.findToWoarea();
//        System.out.println(woareas.toString());
        request.setAttribute("woareas", woareas);
        request.setAttribute("allsentpieces",sentpieces1);
        return "AD/Pie";
    }

    @PostMapping("/addsentpiece")
    public @ResponseBody String AddSentpiece(String seename,String seephone,String seeusername,Long seeworea,String seeadress){
        Sentpieces sentpieces = new Sentpieces();
        sentpieces.setSecreatedate(new Date());
        sentpieces.setSename(seename);
        sentpieces.setSestate(stateService.findStateById((short)1));
        sentpieces.setSephone(seephone);
        sentpieces.setSemailcustomername(seeusername);
        Workingarea workingarea = workingareaService.findworkingareaById(seeworea);
        sentpieces.setSestateadress(workingarea);
        sentpieces.setSeendadress(seeadress);
        List<Post> post = postService.findAppropriatePost(workingarea);
        if (post.isEmpty()){
            return "该区域无正在工作的邮差，请完善";
        }
        Post post1 = post.get(0);
        Integer integer = post1.getPoworkload();
        post1.setPoworkload(integer+1);
        Post post2 = postService.update(post1);
        sentpieces.setSepost(post2);
        sentpiecesService.savesentpieces(sentpieces);
        return "添加派件成功！";
    }

    @PostMapping("/worksituation")
    public String Situation(String poname,Long poid,Date start,Date end,HttpServletRequest request){
        List<Object[]> reQklist = recipientService.getPostReQk(poid,start,end);
//        for (Object[] objects : reQklist){
//            for (Object object : objects){
//                System.out.println(object.toString());
//            }
//            System.out.println("***********");
//        }
        List<Object[]> seQklist = sentpiecesService.findPostSeQK(poid,start,end);
//        for (Object[] objects : seQklist){
//            for (Object object : objects){
//                System.out.println(object.toString());
//            }
//            System.out.println("***********");
//        }
        List<Sentpieces> postidsentpiecesList = sentpiecesService.findSentpiecesTopoid(poid,start,end);
        List<Recipient> postidrecipient = recipientService.findPostRecipient(poid,start,end);
        String st = DateFormat.getDateInstance().format(start);
        String en = DateFormat.getDateInstance().format(end);
        request.setAttribute("pooname",poname);
        request.setAttribute("poostart",st);
        request.setAttribute("pooend",en);
        request.setAttribute("workres",reQklist);
        request.setAttribute("workses",seQklist);
        request.setAttribute("postidsentpiecesList",postidsentpiecesList);
        request.setAttribute("postidrecipient",postidrecipient);
        return "AD/WorkSituation";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        //转换日期 注意这里的转化要和传进来的字符串的格式一直 如2015-9-9 就应该为yyyy-MM-dd
        DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));// CustomDateEditor为自定义日期编辑器
    }

}
