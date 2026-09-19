# bash_profile
* .vimrc - some nice defaults
* .bashrc.d/kubernetes.bashrc - helpful completion and shortcuts
* .bashrc.d/ps1.bashrc - setting up a default PS1

# Usage

- Copy the `*.bashrc` files into $HOME/.bashrc.d
- Add the following to your .bashrc (if it already doesn't exist)
```text
for file in ~/.bashrc.d/*.bashrc;
do
source $file
done
```
