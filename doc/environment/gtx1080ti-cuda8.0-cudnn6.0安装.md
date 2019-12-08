# Deep Learning Environment 

## 1. Introdution
安装Cuda需要显卡支持GPU加速，本机配置如下:

| Hardware | Software          |
| -------- | :---------------- |
| GTX 1080ti | ubuntu 16.04      |
| 16G RAM  | 4.15.0-29-generic |

### 1.1 gcc和g++版本降级
**ubuntu16.04的gcc版本是5.4，而cuda8.0在该系统中支持的gcc版本不超过5.3，所以第一步需要对GCC版本进行降级**
> `$ sudo apt-get install -y gcc-4.8`\
  `$ sudo apt-get install -y g++-4.8`\
  `$ cd /usr/bin`\
  `$ sudo rm gcc`\
  `$ sudo ln -s gcc-4.8 gcc`\
  `$ sudo rm g++`\
  `$ sudo ln -s g++-4.8 g++`\
  `$ gcc -v`\
  `$ g++ -v`

### 1.2 Cuda 8.0 install
- 查看显卡配置：
   > `$ ubuntu-driver devices`
- 安装nvidia 驱动，可以先删除系统自带的nvidia驱动
    > `$ sudo apt-get remove --purge nvidia*`\
    > `$ sudo apt-get install nvidia-384`
    
    有的网上教程中说需要禁用X服务再安装，但我这边没有禁用也安装成功，禁用命令如下: \
    **需要在命令行中操作 Ctrl+alt+F1，仅供参考**
    > `$ sudo service lightdm  stop`\
      `$ sudo service lightdm  start`

- 检查是否安装成功
    > `$ nvidia-smi`
- [下载](https://developer.nvidia.com/cuda-80-ga2-download-archive)和安装cuda 8.0
    > `$ sudo ./cuda*.run  #除了第二项"是否安装显卡驱动"选择no之外，其他全部按默认设定`

- 测试安装是否成功（重启后）
    > $ `nvcc -V`
 
    如果出现 **NVIDIA-SMI has failed because it couldn't communicate\with the NVIDIA drive**错误，解决方案如下:
    * 禁用nouveau驱动（建议在安装nvidia-driver前就禁用nouveau驱动，编辑 */etc/modprobe.d/blacklist-nouveau.conf* 文件，添加以下内容：
        > blacklist nouveau\
          blacklist lbm-nouveau\
          options nouveau modeset=0\
          alias nouveau off\
          alias lbm-nouveau off
    * 然后保存。关闭nouveau：
        > `$ echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf`
    * 重启
        > `$ update-initramfs -u`\
          `$ sudo reboot`
    * PS: 也有可能是内核版本过高的问题，如果上述操作没有解决，可以尝试使用低版本内核验证

- 到此CUDA安装完毕了....， 需要设置环境变量
    * 在文件最后加上下面两句（如果你安装时使用的是默认路径的话）
        > `$ sudo vi /etc/profile`

        > `export PATH=/usr/local/cuda-8.0/bin:$PATH`\
        `export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH`  

    * 使环境变量立即生效
        > `$ sudo ldconfig`

    * 因为接下来安装Samples需要make，所以得先装好一些库和依赖
        > `$ sudo apt-get install freeglut3-dev build-essential libx11-dev libxmu-dev   libxi-dev  libglu1-mesa libglu1-mesa-dev libgl1-mesa-glx `

    * 安装CUDA自带的Samples
        > `$ cd /usr/local/cuda/samples`\
          `$ sudo make all -j8`

    * 编译时间较久，编译完之后
        > `$ cd ./bin/x86_64/linux/release`\
          `$ ./deviceQuery #若出现显卡信息，则说明安装完成了`

### 1.3 cudnn 6.0 的安装教程
    
* [cudnn下载链接](https://developer.nvidia.com/rdp/cudnn-archive) 
* 安装命令
    > `$ tar -xvf cudnn-8.0-linux-x64-v6.0.tgz `\
      `$ cd cuda/ `\
      `$ sudo cp include/cudnn.h /usr/local/cuda/include `\
      `$ sudo cp -a lib64/libcudnn* /usr/local/cuda/lib64`

* 查看安装结果
    > `$ sudo cat /usr/local/cuda/include/cudnn.h | grep`
    
    出现以下结果表明安装成功
    >  #define CUDNN_MAJOR      6 \
        #define CUDNN_MINOR      0 \
        #define CUDNN_PATCHLEVEL 21 \
        -- \
        #define CUDNN_VERSION    (CUDNN_MAJOR * 1000 + CUDNN_MINOR * 100 + CUDNN_PATCHLEVEL) \
        #include "driver_types.h"