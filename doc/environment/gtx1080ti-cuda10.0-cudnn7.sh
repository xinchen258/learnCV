# /bin/bash

# 安装nvidia驱动
sudo apt-add-repository -r ppa:graphics-drivers/ppa
sudo apt update
sudo apt remove nvidia*
sudo apt autoremove
sudo apt-get install nvidia-driver-410

# cuda10和cudnn7下载链接（以下两个链接已过期，需要去官网获取后替换）
wget https://developer.download.nvidia.cn/compute/cuda/10.0/secure/Prod/local_installers/cuda_10.0.130_410.48_linux.run?JXHf1XDk2eEi8lRii0_YRxBAJROg3E5LDtmlwqlsr8DAEV69-A6CjYvHi_sIQHJyrJuS020PWIdPhjn2qZJrota2hn06_VVxApPt3VzZn4Qz_hGnMYwnYbo1ykC6qoymsUco0MiTp5iCR2OkcIg7VTGcQNFlA0_oR1UEHA0hA5KI9CLXIXZle-XuaCA
wget https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/7.6.3.30/Production/10.0_20190822/cudnn-10.0-linux-x64-v7.6.3.30.tgz?0VGiL3LxsPDueg-IvgZUtjwm-AraC8yKY7elxDUUtgclNKtVdTKY1uafeZIyylEZYq9e2gn03fLbky_QB_ycCml1WV9spKcS11LamvcW-yq_5duazPfhAvH0jGlpKeMhAR6-TZ--d_zlkI7O9JtM7SzqijC9dEltn1Pz38ud4Bi4wh5a4iBHCQYH08RM3TmNpPsYRwOVom0_CGKukgBj3cCk12b-a0JxzA

# 安装cuda10
sudo sh cuda_10.0.130_410.48_linux.run

# 安装cudnn7
tar -xvf cudnn-10.0-linux-x64-v7.6.3.30.tgz
cd cuda/
sudo cp include/cudnn.h /usr/local/cuda/include
sudo cp -a lib64/libcudnn* /usr/local/cuda/lib64

#添加cuda环境变量(手动添加方法：$vim ~/.bashrc && $source ~/.bashrc)

echo 'export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH' >> ~/.bashrc

echo 'export CUDA_HOME=/usr/local/cuda-10.0:$CUDA_HOME'  >> ~/.bashrc
echo 'export PATH=/usr/local/cuda-10.0/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc


