package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 收件
 */
@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_RECIPIENT")
public class Recipient implements Serializable{
    private static final long serialVersionUID = 5139796295142133024L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "RE_ID")
    private Long reid;

    @Column(name = "RE_NAME",length = 50)
    private String rename;

    @Column(name = "RE_PHONE",length = 15)
    private String rephone;

    @Column(name = "RE_STATEADRESS",length = 255)
    private String restateadress;

    @Column(name = "RE_COUNT")
    private Float recount;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = Post.class)
    @JoinColumn(name = "RE_POST_ID",referencedColumnName = "PO_ID",foreignKey = @ForeignKey(
            name = "RE_POST_RECIPIENT"
    ))
    private Post repost;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = Mailcustomer.class)
    @JoinColumn(name = "RE_MAILCUSTOMER_ID",referencedColumnName = "MA_ID",foreignKey = @ForeignKey(
            name = "RE_MAIL_RECIPIENT"
    ))
    private Mailcustomer remailcustomer;

    @Column(name = "RE_CREEATERDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date recreaterdate;

    @Column(name = "RE_EDNDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date reenddate;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = State.class)
    @JoinColumn(name = "RE_STATE",referencedColumnName = "ST_ID")
    private State restate;

    @ManyToOne(targetEntity = Workingarea.class)
    @JoinColumn(name = "RE_ENDADRESS",referencedColumnName = "WO_ID")
    private Workingarea reendadress;
}
