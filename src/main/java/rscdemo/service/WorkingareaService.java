package rscdemo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rscdemo.jpa.WorkingareaJpa;
import rscdemo.pojo.Workingarea;

import java.util.List;


@Service
public class WorkingareaService {
    @Autowired
    WorkingareaJpa workingareaJpa;

    public Workingarea findworkingareaById(Long woid){
        return workingareaJpa.getWorkingareaById(woid);
    }

    public List<String> findToWoarea(){
        return workingareaJpa.getWoarea();
    }

    public List<Workingarea> findAllWorkingArea(){
        return workingareaJpa.getAllWorkingarea();
    }

    public List<Workingarea> findWoidAndWotown(String woarea){
        return workingareaJpa.getWoidAndWoarea(woarea);
    }
}
