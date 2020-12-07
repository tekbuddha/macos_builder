## macos_builder

This is a highly opinionated setup script that automatically configures my MacOS systems to a "usable" state following a clean MacOS install. This gets me as pretty close to useable in a realively short period of time.

### Dependencies

This script makes use of XCode's Command Line Tools (namely, `git`, `gcc`, and other build-type tools). The quickest way to get this installed is to open `Terminal.app` and issue a quick `gcc`, which will then prompt you to install the CLT package.

This script also makes use of the MacOS App Store, so you should ensure you're signed into the App Store before starting. If for some reason you miss that and receive errors during the package install stage, no problem! Just run `brew bundle` from the same directory you've placed this script and it should pick up cleanly.

### How It Works

Basically it works like so:

1. Names the Mac what you'd like to
2. Installs [Homebrew](https://brew.sh)
3. Installs a number of brew packages, casks, and applications from the Mac AppStore using [mas](https://github.com/mas-cli/mas)
4. Set a number of UI/UX and application preferences using MacOS' `defaults` and similar tooling.

### How To Use

1. Select 'Download Zip' from the Github [page](https://github.com/tekbuddha/macos_builder), `git clone`, or work from your own fork. 
1. `./macos_builder.sh`
1. Viola! A Mac with tons of apps and settings is ready to roll.

## Author

| [![twitter/tekbuddha](https://en.gravatar.com/userimage/270265/3ce5a7d2212c15b6072cafbe898c687e.jpg)](http://twitter.com/tekbuddha "Follow @tekbuddha on Twitter") |
|---|
| [John Martin](http://tekbuddha.com/) |

## Copyright and License

No copyright. It's a shell script to setup a workstation for cryin' out loud! Fork it, clone it, whatever. Use as you find helpful.