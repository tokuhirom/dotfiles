# check the environment variable's availability

    if [ -z "$var" ]
    then
          echo "\$var is empty"
    else
          echo "\$var is NOT empty"
    fi

# BASEDIR

    BASEDIR=$(dirname "$0")
    echo "$BASEDIR"
