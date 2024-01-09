#!/usr/bin/env bash

# help menu for command usage
__help() {
  echo -e "Usage: build [-h] [-c] -b [-s] [-i]\n";
  echo "-b        build the supersuper binary";
  echo "-c        check all source files for errors";
  echo "-h        show help options";
  echo "-i        install the superuser binary";
  echo "-s        compress the superuser binary with upx";
  exit 0;
};

# check each source file for errors
__check() {
  # current working directory
  local current_dir="$(pwd)";

  # command line arguments to be passed to nim
  local arg1="--forceBuild:on --checks:on --stdout:off --hints:off ";
  local arg2="--colors:on --assertions:on --filenames:abs ";
  local arg3="--warnings:on --styleCheck:error --run compile ./src/Main.nim";
  local arg4="${arg1}${arg2}${arg3}";

  if [ ! -d "$current_dir/src/" ]; then
    echo -e "\n\e[1;31mNo directory named\e[0m\e[1;37m'src'\e[0m";
    return 1;
  fi;

  echo -e "\e[1;32mChecking...\e[0m";

  if ( nim $arg4 ); then
    if ( cd ./src/ && rm Main ); then
      echo -e "\e[1A\e[2K\e[1;32mCHECK PASSED\e[0m\e[1;37m!\e[0m";
      return 0;
    
    else
      echo -e "\e[1A\e[2K\e[1;31mCHECK FAILED\e[0m\e[1;37m!\e[0m";
    fi;
  fi;

  return 1;
};

# build the superuser binary file
__build() {
  # current working directory
  local current_dir="$(pwd)";

  # arguments to be passed to nim
  local arg1="--gcc.exe:musl-gcc --linker.exe:musl-gcc --passL:-static";
  local arg2="--threads:on --opt:speed -d:Release --hints:off --checks:off";
  local arg3="--warnings:off --styleCheck:off --stdout:off";
  local arg4="--assertions:off --forceBuild:on --out:superuser compile ./src/Main.nim";
  local arg5="$arg1 $arg2 $arg3 $arg4";

  if [ -f "./bin/superuser" ]; then
    echo -e "\n\e[1;33m$current_dir/superuser already exists.\e[0m \e[1;37mRemoving...\e[0m";
    sleep 2;

    if ( rm -r "./bin/superuser" 2>/dev/null ); then
      echo -e "\e[1A\e[2K\e[1;37mRemoved $current_dir/bin/superuser\e[0m";
    fi;
  fi;
 
  sleep 2;
  echo -e "\e[1A\e[2K\e[1;32mBuilding...\e[0m";

  if ( nim $arg5 ); then
    echo -e "\e[1A\e[2K\e[1;32mBUILD SUCCESSFUL\e[0m\e[1;37m!\e[0m";

    if ( mv ./superuser ./bin/superuser ); then
      echo -e "\e[1;37mMoved $current_dir/superuser -> $current_dir/bin/superuser\e[0m";
      return 0;

    else
      echo -e "\n\e[1;31mNo file named\e[0m '\e[1;37msuperuser'\e[0m";
    fi;

  else
    echo -e "\e[1A\e[2K\e[1;31mBUILD FAILED\e[0m\e[1;37m!\e[0m";
  fi;

  return 1;
};

# compress the superuser binary file
__compress() {
  # current working directory
  local current_dir="$(pwd)";

  if [ -f "/usr/bin/upx" ]; then
    echo -e "\n\e[1;32mCompressing...\e[0m";
    sleep 1;

    if ( cd "./bin/" && upx -q --best --ultra-brute "$current_dir/bin/superuser" &>/dev/null ); then
      echo -e "\e[1A\e[2K\e[1;32mCOMPRESSION SUCCESSFUL\e[0m\e[1;37m!\e[0m";
      return 0;

    else
      echo -e "\e[1A\e[2K\e[1;31mCOMPRESSION FAILED\e[0m\e[1;37m!\e[0m";
      sleep 1;
    fi;
  fi;

  return 1;
}

# install the superuser binary into specified location
__install() {
  # current working directory
  local current_dir="$(pwd)";

  # superuser binary file (default) destination
  local local_install=0;

  # superuser binary file (fallback) destination
  local global_install=0;

  if [ -d "$HOME/.local/bin" ]; then
    local_install=1;
  fi;

  if [ -d "/usr/local/bin" ]; then
    global_install=1;
  fi;

  if [ "$local_install" == 1 ] || [ "$global_install" == 1 ]; then
    echo -e "\n\e[1;32mInstalling...\e[0m";
    sleep 2;

    if ( cd "./bin/" && cp -r "./superuser" "$HOME/.local/bin/superuser" ); then
      echo -e "\e[1A\e[2K\e[1;32mINSTALL SUCCESSFUL\e[0m\e[1;37m!\e[0m";
      echo -e "\e[1;37mCopied $current_dir/superuser -> $HOME/.local/bin/superuser\e[0m";
      return 0;
    
    elif ( cd "./bin/" && sudo cp -r "./superuser" "/usr/local/bin/superuser" ); then
      echo -e "\e[1A\e[2K\e[1;32mINSTALL SUCCESSFUL\e[0m\e[1;37m!\e[0m";
      echo -e "\n\e[1;37mCopied $current_dir/superuser -> /usr/local/bin/superuser\e[0m";
      return 0;

    else
      echo -e "\e[1A\e[2K\e[1;31mINSTALL FAILED\e[0m\e[1;37m!\e[0m";
    fi;
  fi;

  return 1;
};

# process command line arguments
__process_arguments() {
  local arg1="$1";
  local arg2="$2";
  local arg3="$3";
  local arg4="$4";

  if [ $# -eq 0 ]; then
    __help;
  
  elif [ $# -eq 1 ]; then
    if [ "$arg1" == "-h" ]; then
      __help;

    elif [ "$arg1" == "-b" ]; then
      __build;

    elif [ "$arg1" == "-c" ]; then
      __check;

    else
      echo -e "\n\e[1;31mNot Enough Arguments\e[0m";
      return 1;
    fi;

  elif [ $# -eq 2 ]; then
    if [ "$arg1" == "-c" ] && [ "$arg2" == "-b" ]; then
      __check;
      test $? -eq 0 && __build;

    elif [ "$arg1" == "-b" ] && [ "$arg2" == "-s" ]; then
      __build;
      test $? -eq 0 && __compress;

    elif [ "$arg1" == "-b" ] && [ "$arg2" == "-i" ]; then
      __build;
      test $? -eq 0 && __install;

    else echo -e "\n\e[1;31mInvalid Arguments\e[0m";
      return 1;
    fi;

  elif [ $# -eq 3 ]; then
    if [ "$arg1" == "-c" ] && [ "$arg2" == "-b" ] && [ "$arg3" == "-s" ]; then
      __check;
      test $? -eq 0 && __build;
      test $? -eq 0 && __compress;

    elif [ "$arg1" == "-c" ] && [ "$arg2" == "-b" ] && [ "$arg3" == "-i" ]; then
      __check;
      test $? -eq 0 && __build;
      test $? -eq 0 && __install;

    elif [ "$arg1" == "-b" ] && [ "$arg2" == "-s" ] && [ "$arg3" == "-i" ]; then
      __build;
      test $? -eq 0 && __compress;
      test $? -eq 0 && __install;

    else
      __help;
    fi;

  elif [ $# -eq 4 ]; then
    if [ "$arg1" == "-c" ] && [ "$arg2" == "-b" ] && [ "$arg3" == "-s" ] && [ "$arg4" == "-i" ]; then
      __check;
      test $? -eq 0 && __build;
      test $? -eq 0 && __compress;
      test $? -eq 0 && __install;

    else
      echo -e "\n\e[1;31mInvalid Arguments\e[0m";
      return 1;
    fi;

  else
    echo -e "\n\e[1;31mToo Many Arguments\e[0m";
    return 1;
  fi;

  return 0;
};

__main() {
  local args="$@";
  local system="$(uname -s)";
  local arch="$(uname -m)";
  local hasnim=0;
  local hasmusl=0;

  if [ "$system" == "Linux" ] && [ "$arch" == "x86_64" ]; then
    if ( which nim &>/dev/null ); then
      hasnim=1;

    else
      echo -e "\e[1;31m'nim' must be installed\e[0m";
      return 1;
    fi;

    if ( which musl-gcc &>/dev/null ); then
      hasmusl=1;

    else
      echo -e "\e[1;31m'musl-gcc' must be installed\e[0m";
      return 1;
    fi;
    
    __process_arguments $args;

  else
    echo -e "\n\e[1;33mWARNING\e[0m\e[1;37m: Platform not supported\e[0m";
    exit 1;
  fi;

  exit 0;
};

__main $@;
