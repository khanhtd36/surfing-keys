## Build

    npm install
    npm run build:prod

    browser=firefox npm run build:prod             # build webextension for firefox

    npm run build:dev                         # build development version
    browser=firefox npm run build:dev         # build development version for firefox

## Load Extension

To load the extension:
1. Build using npm.
2. Open the browser's extension page. 
  - For Chrome, this can be accessed through "chrome://extensions".
3. Disable the Surfingkeys extension that was installed from the Google Chrome Store.
4. Enable "Developer mode" then click "Load unpacked."
5. For versions prior to v1.x, navigate to `<pathToSurfingkeys>/dist/Chrome-extensions`
6. For version v1.x, navigate to `<pathToSurfingkeys>/dist/<env>/<browser>`.
