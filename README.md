# pass-ssh
This is a simple script that allows for automatic retrieval of ssh key passwords from [pass](https://www.passwordstore.org/).

## Usage

Simply store entries for a key under a top-level folder "SSH" in pass, and name the entry after the key itself.

```sh
$ ls ~/.ssh
config  id_ed25519_github  id_ed25519_github.pub  known_hosts  sockets/
$ pass
Password Store
└── SSH
    └── id_ed25519_github
```

`SSH_ASKPASS_FOLDER` can be set to change the top-level folder name to something else in order to support multiple directories of keys, perhaps with names that would otherwise collide.

Ensure your ssh-agent is running and add the following variables to your [environment](https://wiki.archlinux.org/index.php/Environment_variables) (e.g. `~/.pam_environment`, `.bash_profile`, or `.zshenv`):

```sh
SSH_ASKPASS_REQUIRE=force
SSH_ASKPASS="/path/to/askpass.sh"
```

Now, whenever you try to `ssh` or `ssh-add`, you will be prompted for your GPG key password, and `pass` will automatically feed the appropriate password to the agent.

When you are done, remember to run `ssh-add -D` to clear your keys from the agent.
