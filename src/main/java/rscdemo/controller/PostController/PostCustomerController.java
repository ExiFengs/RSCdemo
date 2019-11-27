package rscdemo.controller.PostController;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import rscdemo.pojo.Post;
import rscdemo.pojo.Recipient;
import rscdemo.pojo.Sentpieces;
import rscdemo.pojo.State;
import rscdemo.service.PostService;
import rscdemo.service.RecipientService;
import rscdemo.service.SentpiecesService;
import rscdemo.service.StateService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/post")
public class PostCustomerController {

    @Resource
    PostService postService;

    @Resource
    SentpiecesService sentpiecesService;

    @Resource
    StateService stateService;

    @Resource
    RecipientService recipientService;

    @GetMapping("/index")
    public String postindex() {
        return "WO/Index";
    }

    @PostMapping("/login")
    public @ResponseBody
    String getPost(String name, String password, HttpServletRequest request) {
        Post post = postService.findPost(name, password);
        if (post == null) {
            return String.valueOf(0);
        } else {
            request.getSession().setAttribute("post", post);
            return String.valueOf(1);
        }
    }

    @GetMapping("/receipt/{page}")
    public String getreceipt(@PathVariable int page, HttpServletRequest request) {
        Post post = (Post) request.getSession().getAttribute("post");
        Sort sort = new Sort(Sort.Direction.DESC, "reid");
        Pageable pageable = PageRequest.of(page - 1, 10, sort);
        Page<Recipient> recipients = recipientService.findRecipientToPost(post.getPoid(), pageable);
        List<Recipient> recipients1 = recipients.getContent();
        System.out.println(recipients1.toString());
        List<State> lose = stateService.findLose("失败");
//        System.out.println(lose.toString());
        request.setAttribute("lose", lose);
        isreoverdue(recipients1);
        request.setAttribute("postrecipients", recipients1);
        return "WO/Receipt";
    }

    @GetMapping("/sendpieces/{page}")
    public String getPieces(@PathVariable int page, HttpServletRequest request) {
        Post post = (Post) request.getSession().getAttribute("post");
        Sort sort = new Sort(Sort.Direction.DESC, "seid");
        List<State> lose = stateService.findLose("失败");
//        System.out.println(lose.toString());
        request.setAttribute("lose", lose);
        Pageable pageable = PageRequest.of(page - 1, 10, sort);
//        System.out.println(post.getPoid());
        Page<Sentpieces> sentpieces = sentpiecesService.getToPost(post.getPoid(), pageable);
        List<Sentpieces> sentpieces1 = sentpieces.getContent();
        isoverdue(sentpieces1);
        request.setAttribute("postsentpieces", sentpieces1);
        return "WO/Home";
    }

    @PostMapping("/getcount")
    public @ResponseBody
    String discount(Long reid, String renamy) {
//        System.out.println(reid+"*********************************************");
        Recipient recipient = recipientService.findRecipientToId(reid);
        Float f = Float.valueOf(renamy);
//        System.out.println(f);
        recipient.setRecount(f);
        State state = stateService.findStateById((short) 2);
        recipient.setRestate(state);
        recipientService.saveRecipient(recipient);
        return "更改成功！";
    }


    @PostMapping("/operation")
    public @ResponseBody
    String sentoperation(Short type, Long id) {
        State state = stateService.findStateById(type);
        Sentpieces sentpieces = sentpiecesService.findSentipiecesById(id);
        if (type == 3) {
            sentpieces.setSeenddate(new Date());
        }
        if (type == 0 || type == 4 || type == 5 || type == 6) {
            Post p = sentpieces.getSepost();
            Integer integer = p.getPoworkload();
            p.setPoworkload(integer - 1);

            postService.update(p);
        }
        sentpieces.setSestate(state);
        sentpiecesService.savesentpieces(sentpieces);
        return "更改成功";
    }

    @PostMapping("/operationre")
    public @ResponseBody
    String recipient(Short type, Long id) {
        State state = stateService.findStateById(type);
        Recipient recipient = recipientService.findRecipientToId(id);
        if (type == 3) {
            recipient.setReenddate(new Date());
        }
        if (type == 0 || type == 4 || type == 5 || type == 6) {
            Post p = recipient.getRepost();
            Integer integer = p.getPoworkload();
            p.setPoworkload(integer - 1);
            postService.update(p);
        }
        recipient.setRestate(state);
        recipientService.saveRecipient(recipient);
        return "更改成功";
    }

    public void isoverdue(List<Sentpieces> sentpieces) {
        for (int i = 0; i < sentpieces.size(); i++) {
            if (sentpieces.get(i).getSestate().getStid() == (short)1||sentpieces.get(i).getSestate().getStid() == (short)2) {
            Date date = sentpieces.get(i).getSecreatedate();
            if (date.getTime() + 259200000 < new Date().getTime()) {
                sentpieces.get(i).setSestate(stateService.findStateById((short) 0));
                Post post = sentpieces.get(i).getSepost();
                Integer integer = post.getPoworkload();
                post.setPoworkload(integer - 1);
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
