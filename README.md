## osxbuilder

This is a (highly opinionated) setup script that automatically configure my OS X systems to a "usable" state following a clean OS X install. This gets me as pretty close to useable in a realively short period of time.

**NOTE:** It is presumptious in use of my `dotfiles` Github repo, which will break for you given it is a private repo. I would suggest commenting out that section of the script prior to use. Everything else should work well.

## XCode Command Line Tools

This script makes use of XCode's Command Line Tools (namely, `git`). As the DMG for this toolset is behind Apple's Developer website, the quickest way to get this installed is to open `Terminal.app` and issue a quick `gcc`, which will then prompt you to install the CLT package.

## How To Use

1. Install XCode Command Line Tools.
2. `curl https://raw.githubusercontent.com/tekbuddha/osxbuilder/master/osxbuilder.sh | bash`
1. Profit!

*or...*

1. Install XCode Command Line Tools.
1. Select 'Download Zip' from the Github [page](https://github.com/tekbuddha/osxbuilder) or from your own fork. 
1. Unzip `osxbuilder.zip` by double clicking. 
1. cd ~/Downloads/osxbuilder
1. bash ./osxbuilder.sh
1. Profit!


## Author

John Martin

+ [Github](https://github.com/tekbuddha)
+ [Twitter](https://twitter.com/tekbuddha)

## Copyright and License

No copyright. It's a shell script to setup a workstation for cryin' out loud! Fork it, clone it, whatever. Use as you find helpful.