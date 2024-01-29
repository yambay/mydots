To activate the CRC code completion, run this:
```zsh
rm -f /usr/local/share/zsh/site-functions/_crc
crc completion zsh > /usr/local/share/zsh/site-functions/_crc
```

```zsh
$ kubectl completion zsh > "${fpath[1]}/_kubectl"
$ rustup completions zsh > "${fpath[1]}/_cargo"
```

