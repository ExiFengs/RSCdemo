package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

/**
 * 工作区域
 */
@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_WORLKINGAREA")
public class Workingarea {
    private static final long serialVersionUID = 6837521369100641932L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "WO_ID")
    private Long woid;

    @Column(name = "WO_AREA",length = 50)
    private String woarea;

    @Column(name = "WO_TOWN",length = 50)
    private String wotown;


}
