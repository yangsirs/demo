#!/bin/bash
##
########  变量配置  ########################
Gcc_v=9.1.0
Cmake_v=3.15.4
Work_dir=/app/src

#######  环境依赖包  ###################################  
config_env(){
    yum -y install wget  ncurses  ncurses-devel  libaio-devel  openssl openssl-devel bzip2   glibc-headers glibc-static  tmux make cmake
}
####### 安装gcc 高版本方法 ##################################
gcc_install(){
    echo  -e "\e[1;33m -- #### 开始安装gcc 高版本 ###### -- \e[0m"
    cd   $Work_dir
    [ -f gcc-${Gcc_v} ] && rm -rf gcc-${Gcc_v}
    [ -f "gcc-${Gcc_v}.tar.gz" ] ||  wget http://ftp.gnu.org/gnu/gcc/gcc-${Gcc_v}/gcc-${Gcc_v}.tar.gz
    tar  -xf gcc-${Gcc_v}.tar.gz 
    cd gcc-${Gcc_v} 
    ./contrib/download_prerequisites
    ./configure --prefix=/usr/local/gcc  --enable-bootstrap  --enable-checking=release --enable-languages=c,c++ --disable-multilib
    make -j3 &&  make install
    if [ $? -eq 0 ]; then
        sed -i '$aexport PATH=/usr/local/gcc/bin:$PATH'                          /etc/profile
        sed -i '$aexport C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/gcc/include/' /etc/profile
        sed -i '$aexport LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gcc/lib64'  /etc/profile
        source /etc/profile
    else
        exit 1
    fi 
    gcc -v
}

####### 安装cmake 高版本 ####################################
cmake_install(){
    echo  -e "\e[1;33m -- #### 开始安装cmake 高版本 ###### -- \e[0m"
    sleep 5
    # 大版本号
    Big_v=`echo  $Cmake_v | cut -d . -f1-2`
    
    cd   $Work_dir
    [ -f cmake-${Cmake_v} ] &&  rm -rf cmake-${Cmake_v}
    [ -f "cmake-${Cmake_v}.tar.gz" ]  || wget https://cmake.org/files/v${Big_v}/cmake-${Cmake_v}.tar.gz
    tar xf cmake-${Cmake_v}.tar.gz 
    cd  cmake-${Cmake_v}
    ./configure --prefix=/usr/local/cmake
    make -j 3 && make  install
    
    #环境变量path
    yum -y remove  cmake gcc gcc-c++
    sed -i '$aexport PATH=$PATH:/usr/local/cmake/bin'  /etc/profile
    source /etc/profile
    cmake -version
}

while  [ 1 ] 
do
    echo
    echo -e "\t\t\tSys Admin Menu\n"
    echo -e "\t  1. Install gcc:    ${Gcc_v}\n"
    echo -e "\t  2. Install cmake:  ${Cmake_v}\n"
    echo -e "\t  0. 退出脚本程序 \n"
    read -n 1 -p "Please Input  Numbers : "  NUM
    case $NUM in
        1)
        config_env;
        echo  -e "\033[34m  安装GCC 环境 ............... \033[0m"
        sleep 2
        gcc_install;;

        2)
        echo  -e "\033[34m  安装CMAKE 环境 ............... \033[0m"
        config_env;
        cmake_install;;
        0)
        echo -e "\n"
        exit 1
        ;;
        *)
        clear
        echo  -e "\033[34m  Please  Input  [ 1 | 2 | 0 ]  \033[0m"
    esac
    echo -en "\n\n\t\t\t 任意键继续"
    read -n 1 line
done
