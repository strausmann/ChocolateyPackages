# <img src="https://rawcdn.githack.com/strausmann/ChocolateyPackages/502da828ff77bbc4ace5cb8f2683a47ce9858719/icons/pangolin.png" width="48" height="48"/> [pangolin-newt](https://community.chocolatey.org/packages/pangolin-newt)

Chocolatey package for [Newt](https://github.com/fosrl/newt), the site and network connector for [Pangolin](https://pangolin.net/).

Optional Windows-service install via package parameters:

    choco install pangolin-newt --params "/Id:<site-id> /Secret:<secret> /Endpoint:https://<host>"

Without parameters only the `newt` binary is placed on the PATH. Automatically maintained (chocolatey-au) against fosrl/newt releases.

Published as `pangolin-newt` because the `newt` id on the Community Repository is an unrelated legacy tool.
