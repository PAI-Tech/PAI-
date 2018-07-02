# PAI-OS-LINUX

PAI-Linux prepare (on clean ubuntu 16.04):
from PAI-CODE/external-scripts/pai-ubuntu-prepare.sh.

- Install pre-requisite pkgs:
    pydf
    zip
    unzip
    htop
    git
    build-essentials
    libssl-dev
    libffi-dev
    python pkgs
    
- Update locales + set time to UTC
- Handle sudoers - only users in the sudo group able to run su command
- Update profiles
- SSH setup - Password authentication
- Install Java - latest version
- Install Docker - latest version
- Set a startup file


# PAI-OS install folders script

- In ubuntu:/var/PAI/Backup
                    /Bot
                    /Config
                    /Logs
                    /PAI-CODE/external-scripts
                    /System
                    /Startup

- Logs folder permisssions
- PAI-CODE folder permissions
- Config folder permissions
- Update config file
- Git clone PAI-OS-LINUX
- Copy System folder to $PAI folder
- Copy Startup folder to $PAI folder
