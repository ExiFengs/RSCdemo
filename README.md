# RSCdemo
RSC快递员系统
## 根据springboot和jpa和jsp搭建的一个简易收件派件系统


# 1、项目简介

本项目主要分为3个模块：
（1）邮客模块
（2）邮差模块
（3）管理员模块

# 2、数据库模型如下：
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184034285.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
 # 3、项目结构如下：
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184059484.png)
 # 4、功能模块细则：
 （1）邮客模块
1、邮客注册、登录
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184140568.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
关键代码：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184143578.png)

注册模块：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184154833.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
2、邮客登录以后可以查看自己的权限以及快递信息
当每个邮客注册登录后，他的权限都为新用户：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184157799.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
代码：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184211482.png)
当邮客想要寄件时，必须完善自己的信息：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184219455.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184224381.png)
代码：

```java
@ResponseBody
String resuleinfo(HttpServletRequest request, String username, String phone, Long woid, String address) {
    Mailcustomer = (Mailcustomer) request.getSession().getAttribute("mailcustomer");
    mailcustomer.setManame(username);
    mailcustomer.setMaadress(address);
    mailcustomer.setMaworkingarea(workingareaService.findworkingareaById(woid));
    mailcustomer.setMaphone(phone);
    if (mailcustomer.getMarole().getRoid() == 1) {
        mailcustomer.setMarole(roleService.findRoleById((short) 2));
    }
    mailcustomerService.savemailcustomer(mailcustomer);
    request.getSession().setAttribute("mailcustomer", mailcustomer);
    return "更改成功！";
}
```
完善自己的信息以后，就可以寄件，并可以看到自己的折扣情况
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184313359.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
点击确定按钮，就能看到自己的寄件情况：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184314807.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)

（2）邮差模块
1、邮差的登录
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184325721.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
代码：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184332297.png)
2、邮差可以查看快件的情况，也可以查看系统给予的任务，用不同颜色显示快件包裹的情况
派件：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019121218434032.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
收件：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184342842.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
当邮差点击正在寄件的时候，会弹出显示需要的金额
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184351660.png)
当邮差输入金额，点击确定以后，会在下方显示邮客需要交付的金额，然后用户也可以看到自己的邮费是多少
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184354261.png)
邮客查看金额：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184405906.png)

代码：

```java
@GetMapping("/receipt/{page}")
    public String getreceipt(@PathVariable int page,HttpServletRequest request){
        Post = (Post) request.getSession().getAttribute("post");
        Sort = new Sort(Sort.Direction.DESC,"reid");
        Pageable = PageRequest.of(page-1,10,sort);
        Page<Recipient> recipients = recipientService.findRecipientToPost(post.getPoid(),pageable);
        List<Recipient> recipients1 = recipients.getContent();
        System.out.println(recipients1.toString());
        List<State> lose = stateService.findLose("失败");
//        System.out.println(lose.toString());
        request.setAttribute("lose",lose);
        isreoverdue(recipients1);
        request.setAttribute("postrecipients",recipients1);
        return "WO/Receipt";
    }
```
   
3、当邮差寄件结束以后，点击完成寄件，邮客同时可以知道快件已经寄出了；当邮客发现快件在寄出过程中出现问题，可点击寄件失败按钮，提示邮客快件寄出过程遇到的问题：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184427467.png)
同时邮客也能知道快件邮寄过程的问题：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184433704.png)
代码：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184441982.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)

（3）管理员模块
1、管理员登录模块
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184449555.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
代码：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184449848.png)

2、管理员可以查看邮客的信息，并修改邮客的权限
注：当邮客没有完善自己的信息时，不能够修改他/她的权限

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184459787.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184503938.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
修改完以后，这里的每一个邮差的权限不同，所对应的颜色显示也不一样
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184521147.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
代码：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019121218452778.png)
3、查看邮差情况（详细信息），也可以新增邮差
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184532323.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184537882.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)

修改邮差信息：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184543898.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
注：当邮差在所在区域有工作时，不能修改其工作区域以及工作状态，而当邮差有事请假在休息中，结束以后，管理员可以修改其状态以及工作区域
 

由上图看出，小强的工作状态已经修改为工作中

代码：

```java
if (workingarea != post.getPoworkarea()) {
            if (repostid.contains(new Short((short) 1)) || repostid.contains(new Short((short) 2)) ||
                    sepostid.contains(new Short((short) 1)) || sepostid.contains(new Short((short) 2))) {
                return "该邮差目前在所处区域有正在进行的工作，不可更改！";
            }else {
                post.setPoworkarea(workingarea);
}
        }
                postService.update(post);
                return "更改成功";
                }

```


4、通过点击工作状况，可以查询某个邮差的工作情况：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184613495.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184619510.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)

5、派件表
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184624577.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)

在这里可以看到分配给每个邮差的任务，同时也可以根据邮客提交的快件订单，分配给每个邮差

查看工作量以及工资:

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184625804.png)
***注：分配原则：在同一区域内，每一个快件会默认派给工作量较少的邮差，因为不可能有的邮差工作量很大，而有的邮差工作量很少，甚至没有工作量，所以在这里设置了优先级***

代码：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184658429.png)

6、收件表
管理员可以通过该表查看每个包裹的情况
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191212184706204.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYzNDI2MA==,size_16,color_FFFFFF,t_70)

本个项目对springboot初学者是一个很好的学习项目，如有兴趣，欢迎star~

源码地址：https://github.com/FsXI/RSCdemo
