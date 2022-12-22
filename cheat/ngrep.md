# install on centos6

    wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    sudo rpm -ivh epel-release-6-8.noarch.rpm
    sudo yum install --enablerepo=epel  -y ngrep

# read 80 port

    ngrep -d any port 80 -W byline

# grep

    ngrep -d any 'error' port syslog

# regexp

    ngrep -wi -d any 'user|pass' port 21

