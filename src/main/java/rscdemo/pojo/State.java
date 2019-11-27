package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;


@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_STATE")
public class State implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ST_ID")
    private Short stid;

    @Column(name = "ST_NAME",length = 8)
    private String stname;

    @Column(name = "ST_DESCRIBE",length = 50)
    private String stdescribe;
}
