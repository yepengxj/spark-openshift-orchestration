#  Spark and Zeppelin on Kubernetes
##简要内容
本编排启动了一个standalone的spark计算集群。包括一个master和3个slave，其中slave的个数可以动态，在编排文件spark-worker-controller.yaml中指定。
当然，还包括与之匹配的master访问端口的service，以及dashboard界面的service和route。
另外，启动了一个zeppelin的容器，一个rc一个service和一个route。
其中注意spark的master slave和zeppelin之间都开启了secret的认证模式。secret通过环境变量通过docker启动命令写入配置文件里面。
##创建顺序
###1.生成master。
执行 spark-master-controller.yaml生成rc;执行spark-master-service.yaml生成管理端口的service（7070），用于客户端以及slave与之通信；执行spark-webui.yaml生成dashboard ui，8080端口，并执行spark-master-route.yaml生成一个ui到外网的路由。
需要注意替换其中的"SPARK_MASTER"变量，替换为spark-master-service.yaml中指定的 名字；替换instanceid字段，但不要太长，service整体名字不能超过24个字符；替换"SPARK_SECRET"变量，这个是密码。
###2.生成slave
执行spark-worker-controller.yaml，生成slave，个数在rc中指定。
替换的变量见前面
必须等master 好了以后才能生成slave，否则注册会失败
###3.生成zeppelin
分别执行zeppelin的三个编排，生成响应的对象。注意替换环境变量
##绑定顺序
直接返回spark master的地址和密码，不创建用户和密码
##其他注意事项

