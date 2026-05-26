tuch ./.id_ed25519_win_ncc.txt

cat ~/.ssh/id_ed25519_win_ncc.pub

echo "NỘI_DUNG_VỪA_COPY" >> ~/.ssh/authorized_keys

tuch ./.id_ed25519_win_git_server_lab.txt

cat ~/.ssh/id_ed25519_win_git_server_lab

ssh-keygen -R "[192.168.2.74]:2222"
