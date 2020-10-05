# pass-ssh
This is a simple wrapper around ssh and ssh-add that allows for automatic retrieval of ssh key passwords from [pass](https://www.passwordstore.org/).

Ultimately this means for that any SSH key, you only need a single GPG passphrase to unlock it.

## Usage

Simply store entries for a key under a top-level folder "SSH" in pass, and name the entry after the key itself.

```
$ ls ~/.ssh
config  id_ed25519_github  id_ed25519_github.pub  known_hosts  sockets/
$ pass
Password Store
└── SSH
    └── id_ed25519_github
```

`SSH_ASKPASS_FOLDER` can be set to change the top-level folder name to something else in order to support multiple directories of keys, perhaps with names that would otherwise collide.

For use with Git, I recommend setting `GIT_SSH` to `pass-ssh` prior to executing the preferred command.

When you are done, remember to run `ssh-add -D` to clear your keys from the agent.
