package rscdemo.service;

import org.springframework.stereotype.Service;
import rscdemo.jpa.StateJpa;
import rscdemo.pojo.State;

import javax.annotation.Resource;
import java.util.List;


@Service
public class StateService {
    @Resource
    StateJpa stateJpa;
    public State findStateById(Short stid){
        return stateJpa.getStateToId(stid);
    }

    public List<State> findLose(String stdescribe){
        return stateJpa.getLose(stdescribe);
    }
}
