package rscdemo.pojo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 管理人员
 */
@Setter
@Getter
@ToString
@Entity
@Table(name = "RSC_MANAGEMENT")
public class Management implements Serializable{
    private static final long serialVersionUID = 6837526111700645861L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "MA_ID")
    private Long maid;

    @Column(name = "MA_LOGINNAME",length = 50)
    private String maloginname;

    @Column(name = "MA_PASSWORD",length = 50)
    private String mapassword;

}
