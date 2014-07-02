# vim-chrome-repl

A work in progress vim plugin that sends javascript to a running Chrome remote
debugger and displays the output.

Currently only displays output logged to the console (ie. console.log) and *not*
the result of expressions like the normal chrome console (which can be confusing
when not displayed inline). Also currently only executes on tab 0 (the currently
visible chrome tab).

thrown exceptions are also caught.

Requires nodejs and a Vim with python support (uses python to manage the
subprocess). The node module [chrome-remote-interface](https://github.com/cyrus-and/chrome-remote-interface) is required and bundled however you might need to rebuild them in the 
`plugin` directory:

```sh
$ cd plugin
$ npm rebuild
```

## Usage

```sh
# start chrome with debugger port
...Chrome.app --args --remote-debugger-port=9222
```

Visually select javascript and run `:call ChromeRepl_SendToChrome()` or map to a
keystroke.

## TODO

* Configurable/menu selectable tab
* Configurable display options (ie. show expression results)
* Default keybind
* Possible debugger support (breakpoints, etc)
