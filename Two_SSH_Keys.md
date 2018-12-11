# How to set up two SSH keys for Github

When you work for a company, you may have a company email address for a new github account, and you also have your personal github account. In this case, if you need to use both ssh conneciton, you need to set up two ssh keys.


Assume the company name is `companyName` and the repo is `repoName`.

## Step 1

Generate keys as usual, but give different names of the pub and private keys.

## Step 2
Create a `.ssh/config` file and have following content,

```bash
# This is for my personal key
Host github.com
    HostName github.com
    User git
    ServerAliveInterval 10
    IdentityFile ~/.ssh/id_rsa

# This is for company - companyName
Host github-companyName # This is the important part
    HostName github.com 
    User git
    ServerAliveInterval 10
    IdentityFile ~/.ssh/id_rsa_ww
```

## Step 3

The trick part is, once you cloned you company repo, you need to change the remote url to a new one. 

Old remote url:
`origin git@github.com:companyName/repoName`

New remote url:
`origin git@github-companyName:companyName/repoName`

Use `git remote set-url` command.

