cat << EOF >> ~/.ssh/config

Host ${hostname}
    hostname ${hostname}
    USER ${user}
    IdentityFile ${identityFile}

EOF