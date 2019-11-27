package rscdemo.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import rscdemo.jpa.PostJpa;
import rscdemo.pojo.Post;
import rscdemo.pojo.Workingarea;

import javax.annotation.Resource;
import java.util.List;


@Service
public class PostService {

    @Resource
    PostJpa postJpa;

    public List<Post> findAppropriatePost(Workingarea workingarea){
        return postJpa.getAppropriatePost(workingarea);
    }

    public Post update(Post post){
        return postJpa.save(post);
    }

    public Post findPost(String name,String password){
        return postJpa.getPost(name,password);
    }

    public Page<Post> findAllPost(Pageable pageable){
        return postJpa.getAllPost(pageable);
    }

    public Post GetPost(Long poid){
        return postJpa.findPostById(poid);
    }

    public List<Integer> getPostWorkload(){
        return postJpa.getPostWorkload();
    }

    public List<String> getPostName(){
        return postJpa.getPostName();
    }
}
