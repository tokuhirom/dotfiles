# ansible-playbook

特定のホストだけ再実行

    ansible-playbook -l web01 site.yml

特定のタグだけ実行


    ansible-playbook site.yml --tags nginx

