#!/usr/bin/env bash

# help menu for build.sh
__help() {
  echo "Usage: build [-c] [--check-only]";
  echo -e "\n-c               compress superuser binary using upx utility";
  echo -e "\n--check-only     perform checks on source code";
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

  else
    echo -e "\n\e[1;32mChecking...\e[0m";
  fi;

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

  if [ ! -d "./bin" ]; then
    ( mkdir "./bin" );
  fi

  if [ -f "./bin/superuser" ]; then
    echo -e "\n\e[1;33m$current_dir/superuser already exists.\e[0m \e[1;37mRemoving...\e[0m";
    sleep 2;

    if ( rm -r "./bin/superuser" 2>/dev/null ); then
      echo -e "\e[1A\e[2K\e[1;37mRemoved $current_dir/bin/superuser\e[0m";
      sleep 2;
      
      echo -e "\e[1A\e[2K\e[1;32mBuilding...\e[0m";
    fi;

  else
    echo -e "\n\e[1;32mBuilding...\e[0m";
  fi;

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

  if [ "$local_install" == 1 ] && [ -f "$HOME/.local/bin/superuser" ]; then
    echo -e "\n\e[1;33m$HOME/.local/bin/superuser already exists.\e[0m \e[1;37mRemoving...\e[0m";
    sleep 2;
    if ( rm -r "$HOME/.local/bin/superuser" ); then
      echo -e "\e[1A\e[2K\e[1;37mRemoved $HOME/.local/bin/superuser\e[0m";
      sleep 2;
      
      echo -e "\e[1A\e[2K\e[1;32mInstalling...\e[0m";
      sleep 2;
    fi;

  elif [ -f "/usr/local/bin/superuser" ]; then
    echo -e "\n\e[1;33m/usr/local/bin/superuser already exists.\e[0m \e[1;37mRemoving...\e[0m";
    sleep 2;
    if ( sudo rm -r "/usr/local/bin/superuser" ); then
      echo -e "\e[1A\e[2K\e[1;37mRemoved /usr/local/bin/superuser\e[0m";
      sleep 2;
      
      echo -e "\e[1A\e[2K\e[1;32mInstalling...\e[0m";
      sleep 2;
    fi;

  else
    echo -e "\n\e[1;32mInstalling...\e[0m";
    sleep 2;
  fi;

  if [ "$local_install" == 1 ]; then
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

__main() {
  local arg="$1";
  local system="$(uname -s)";
  local arch="$(uname -m)";
  local hasnim=0;
  local hasmusl=0;

  if [ "$system" == "Linux" ] && [ "$arch" == "x86_64" ]; then
    if [ -f "${HOME}/.nimble/bin/nim" ]; then
      hasnim=1;

    else
      echo -e "\e[1;31m'nim' must be installed\e[0m";
      return 1;
    fi;

    if [ -f "/usr/bin/musl-gcc" ]; then
      hasmusl=1;

    else
      echo -e "\e[1;31m'musl-gcc' must be installed\e[0m";
      return 1;
    fi;

    if [ $# -eq 0 ]; then
      __check && __build && __install;
    
    elif [ $# -eq 1 ]; then
      if [ "$arg" == "-h" ]; then
        __help;

      elif [ "$arg" == "--check-only" ]; then
        __check;
    
      elif [ "$arg" == "-c" ]; then
        __check && __build && __compress && __install;

      else
        __help;
      fi;

    else
      __help;
    fi;
    
  else
    echo -e "\n\e[1;33mWARNING\e[0m\e[1;37m: Platform not supported\e[0m";
    exit 1;
  fi;

  exit 0;
};

__main $@;
