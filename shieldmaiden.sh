#!/bin/bash
function classShieldmaiden()
{
  # string
  shieldmaidenVersion="0.0.1"
  # array
  validCommandArguments=(
  "--install-all"
  "--install-helpers"
  )

  function outputColorizeText()#: string
  {
    echo -e "\e[${1}${2}\e[0m"
  }

  function outputSeparator()#: string
  {
    outputColorizeText "$1" '===================================='
  }

  function checkIfExecutedByRoot()#: ?string
  {
    if [ "$EUID" -ne 0 ]
      then
        outputColorizeText '31m' "Please run as root (sudo shieldmaiden)"
      exit
    fi
  }

  function guardHasValidArguments()#: bool
  {
    if [ "$2" ]
      then
        outputColorizeText '31m' "Passing second arguments is not valid!"
        return 1 # false
    fi

    for i in "${validCommandArguments[@]}"
      do
        if [ "$i" == "$1" ] ; then
          return 0 # true
        fi
    done

    outputColorizeText '31m' "Invalid argument given"
    return 1 # false
  }

  function printOutHelp() #: string
  {
      echo -e "Help"
  }

  function updateRepositoriesForSupportedOs()#: string|command
  {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      apt update
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      outputColorizeText '31m' "OS is not supported!"
      exit
    elif [[ "$OSTYPE" == "cygwin" ]]; then
      outputColorizeText '31m' "OS is not supported!"
      exit
    elif [[ "$OSTYPE" == "msys" ]]; then
      outputColorizeText '31m' "OS is not supported!"
      exit
    elif [[ "$OSTYPE" == "win32" ]]; then
      outputColorizeText '31m' "OS is not supported!"
      exit
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
      outputColorizeText '31m' "OS is not supported!"
      exit
    else
      outputColorizeText '31m' "OS is not supported!"
      exit
    fi
  }

  function __construct() {
    outputColorizeText '32m' "Shieldmaiden V${shieldmaidenVersion}"
    outputColorizeText '32m' "The mighty Linux security tools installer"
    outputSeparator '32m'

    if guardHasValidArguments "$1"; then
      checkIfExecutedByRoot
      updateRepositoriesForSupportedOs
    else
      printOutHelp
      exit
    fi
  }
   __construct "$1"
}

# Execute Shieldmaiden installer.
classShieldmaiden "$1"