package rscdemo.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.Workingarea;

import java.util.List;


public interface WorkingareaJpa extends JpaRepository<Workingarea,Long>{
    @Query("select w from rscdemo.pojo.Workingarea as w where woid = ?1")
    public Workingarea getWorkingareaById(Long id);

    @Query("select distinct woarea from rscdemo.pojo.Workingarea")
    public List<String> getWoarea();

    @Query("select w from rscdemo.pojo.Workingarea as w")
    public List<Workingarea> getAllWorkingarea();

    @Query("select w from rscdemo.pojo.Workingarea as w where woarea = ?1")
    public List<Workingarea> getWoidAndWoarea(String woarea);
}
