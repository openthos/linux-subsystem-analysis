## 在OPENTHOS Linux子系统下使用Ubuntu

### 在OPENTHOS上使用Ubuntu需要下载以下组件：

- startlss.sh
````
cd /data
scp lh@192.168.0.180:/home/lh/zsm/startas.sh .
````
- ubuntu.img
````
cd /data
scp lh@192.168.0.180:/home/lh/zsm/ubuntu.img .
````
### 各组件功能解释

- ubuntu.img
1. 包含Ubuntu 18.04 rootfs
2. 使用squashfs压缩
3. 每周例行更新

- startas.sh
1. 自动挂载必要目录
- 挂载只读的ubuntu.img到/data/ubuntu-lower挂载点
- 使用overlayfs分别挂载/data/ubuntu-upper、/data/ubuntu-work、/data/ubuntu，使/data/ubuntu目录含有ubuntu rootfs，并可以以cow的方式写入。
2. 自动设置环境变量
3. chroot至Ubuntu并打开bash shell

### 运行步骤
1. 打开终端（Alt+F1或者终端app均可）
2. 确保/data/目录中存在ubuntu.img
3. 执行
````
sh startlss.sh