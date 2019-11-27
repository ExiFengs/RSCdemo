package rscdemo.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import rscdemo.pojo.State;

import java.util.List;

public interface StateJpa extends JpaRepository<State,Short>{
    @Query("select s from rscdemo.pojo.State as s where stid = ?1")
    public State getStateToId(Short stid);

    @Query("select s from rscdemo.pojo.State as s where stdescribe = ?1")
    public List<State> getLose(String stdescribe);
}
