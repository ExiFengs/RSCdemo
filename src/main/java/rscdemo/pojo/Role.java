package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

/**
 * 角色
 */
@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_ROLE")
public class Role {
    private static final long serialVersionUID = 6837526111700641932L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "RO_ID")
    private Short roid;

    @Column(name = "RO_NAME",length = 50)
    private String roname;

    @Column(name = "RO_DISCOUNT")
    private Double rodiscount;

//    @ManyToMany(fetch=FetchType.LAZY, targetEntity=Mailcustomer.class)
//    @JoinTable(name="RSC_MAILCUSTOMER_ROLE", joinColumns=@JoinColumn(name="ROLE_ID", referencedColumnName="RO_ID"),
//            inverseJoinColumns=@JoinColumn(name="USER_ID", referencedColumnName="MA_ID"))
//    private Set<Mailcustomer> users = new HashSet<>();

}
