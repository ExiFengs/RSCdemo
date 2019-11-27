package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 邮差
 */
@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_POST")
public class Post implements Serializable{
    private static final long serialVersionUID = 6837526111700641932L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "PO_ID")
    private Long poid;

    @Column(name = "PO_PASSWORD",length = 50)
    private String popassword;

    @Column(name = "PO_NAME",length = 50)
    private String poname;

    @Column(name = "PO_PHONE",length = 50)
    private String pophone;

    @Column(name = "PO_WORK",length = 4)
    private Boolean powork;

    @ManyToOne(targetEntity = Workingarea.class)
    @JoinColumn(name = "PO_WORKAREA",referencedColumnName = "WO_ID",foreignKey = @ForeignKey(name = "FK_WORD_AREA"))
    private Workingarea poworkarea;

    @Column(name = "PO_WORKLOAD",length = 5)
    private Integer poworkload;

}
