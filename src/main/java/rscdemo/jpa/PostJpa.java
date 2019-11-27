package rscdemo.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.Post;
import rscdemo.pojo.Workingarea;

import java.util.List;

public interface PostJpa extends JpaRepository<Post,Long> {
    @Query("select p from rscdemo.pojo.Post as p where poworkarea = ?1 and powork = 1 order by poworkload")
    public List<Post> getAppropriatePost(Workingarea workingarea);

    @Query("select p from rscdemo.pojo.Post as p where poname = ?1 and popassword = ?2")
    public Post getPost(String poname,String popassword);

    @Query("select p from rscdemo.pojo.Post as p")
    public Page<Post> getAllPost(Pageable pageable);

    @Query("select p from rscdemo.pojo.Post as p where poid = ?1")
    public Post findPostById(Long poid);

    @Query("select p.poworkload from rscdemo.pojo.Post as p")
    public List<Integer> getPostWorkload();
    @Query("select p.poname from rscdemo.pojo.Post as p")
    public List<String> getPostName();
}
