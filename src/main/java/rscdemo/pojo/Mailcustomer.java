package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 邮客
 */
@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_MAIL_CUSTOMER")
public class Mailcustomer implements Serializable{
    private static final long serialVersionUID = 6837525781700641932L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MA_ID")
    private Long maid;

    @Column(name = "MA_LOGINNAME",length = 50)
    private String maloginname;

    @Column(name = "MA_PASSWORD",length = 50)
    private String mapassword;

    @Column(name = "MA_NAME",length = 50)
    private String maname;

    @Column(name = "MA_PHONE",length = 50)
    private String maphone;

    @Column(name = "MA_ADRESS",length = 100)
    private String maadress;

//    @ManyToMany(fetch=FetchType.LAZY, targetEntity=Role.class, mappedBy="users")
//    private Set<Role> roles = new HashSet<>();
    @ManyToOne(fetch = FetchType.LAZY,targetEntity = Role.class)
    @JoinColumn(name = "MA_ROLE",referencedColumnName = "RO_ID")
    private Role marole;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = Workingarea.class)
    @JoinColumn(name = "MA_WORKINGAREA",referencedColumnName = "WO_ID")
    private Workingarea maworkingarea;

}
