#!/bin/sh

if [ -f deploy.trigger ]; then
    echo "$GCE_KEY" > ansible/environments/prod/key.json && echo "$VAULT_KEY" > ansible/vault.key
    eval $(ssh-agent -s) && echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null && mkdir -p ~/.ssh && chmod 700 ~/.ssh
    cd ansible && ansible-playbook playbooks/deploy_db.yml -v
else echo "Database schema or container config wont changed. DB deploy will be skipped."
fi
