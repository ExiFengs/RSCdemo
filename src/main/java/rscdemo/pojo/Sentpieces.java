package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 派件
 */
@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_SENTPIECES")
public class Sentpieces implements Serializable{
    private static final long serialVersionUID = 2145736111700641932L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "SE_ID")
    private Long seid;

    @Column(name = "SE_NAME",length = 50)
    private String sename;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = Workingarea.class)
    @JoinColumn(name = "SE_STATEADRESS",referencedColumnName = "WO_ID")
    private Workingarea sestateadress;

   @Column(name = "SE_MAILCUSTOMERNAME",length = 10)
    private String semailcustomername;

    @Column(name = "SE_CREATEDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date secreatedate;

    @Column(name = "SE_PHONE",length = 50)
    private String sephone;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = Post.class)
    @JoinColumn(name = "SE_POST_ID",referencedColumnName = "PO_ID",foreignKey = @ForeignKey(
            name = "FK_POST_SERT"
    ))
    private Post sepost;

    @Column(name = "SE_ENDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date seenddate;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = State.class)
    @JoinColumn(name = "SE_STATE",referencedColumnName = "ST_ID")
    private State sestate;

    @Column(name = "SE_ENDADRESS",length = 255)
    private String seendadress;

}
