# pangolin.newt

Chocolatey package for [Newt](https://github.com/fosrl/newt), the site and network connector for [Pangolin](https://pangolin.net/).

Optional Windows-service install via package parameters:

    choco install pangolin.newt --params "/Id:<site-id> /Secret:<secret> /Endpoint:https://<host>"

Without parameters only the `newt` binary is placed on the PATH. Automatically maintained (chocolatey-au) against fosrl/newt releases.

Published as `pangolin.newt` because the `newt` id on the Community Repository is an unrelated legacy tool.
