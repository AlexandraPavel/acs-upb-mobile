# Contributing

## Pull Request process

1. Check out [this](https://opensource.com/article/19/7/create-pull-request-github) tutorial if you
don't know how to make a PR.
2. Increase the version number in the `pubspec.yaml` file with the following guidelines in mind:
    - Build number (0.2.1+**4**) is for very small changes and bug fixes (usually not visible to the
    end user).
    - Patch version (0.2.**1**+4) is for minor improvements that may be visible to an attentive end
    user.
    - Minor version (0.**2**.1+4) is for added functionality (i.e. merging a branch that introduces
    a new feature).
    - Major version (**0**.2.1+4) marks important project milestones.
3. Document any non-obvious parts of the code and make sure the commit description is clear on why
the change is necessary.
4. If it's a new feature, write at least one test for it.

## Development tips

* Make sure you have the *Project* view open in the *Project* tab on the left in Android Studio (not
*Android*).
* Flutter comes with *Hot Reload* (the lightning icon, or *Ctrl+\\* / *⌘\\*), which allows you to
load changes in the code quickly into an already running app, without you needing to reinstall it.
It's a very handy feature, but it doesn't work all the time - if you change the code, use Hot Reload
but don't see the expected changes, or see some weird behaviour, you may need to close and restart
the app (or even reinstall).
* If running on web doesn't give the expected results after changing some code, you may need to
clear the cache (in *Chrome*: *Ctrl+Shift+C* / *⌘+Shift+C* to open the Inspect menu, then
right-click the *Refresh* button, and select *Empty cache and Hard reload*.)

## Style guide  

This project uses
[the official Dart style guide](https://dart.dev/guides/language/effective-dart/style)  with the
following mentions:  

* Android Studio (IntelliJ) with the `dartfmt` tool is used to automatically format the code,
including the order of imports.  
* For consistency, the `new` keyword (which is optional in Dart) should **not** be used.  
* Where necessary, comments should use Markdown formatting (e.g. backticks - ` - for code snippets).
* Use only single apostrophes - ' - for strings (e.g. `'hello'` instead of `"hello"`)
* All strings that are visible to the user should be internationalised and set in the corresponding
`.arb` files within the `l10n` folder. The
[Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl) Android Studio plugin does
all the hard work for you by generating the code when you save an `.arb` file. Strings can then be
accessed using `S.of(context).stringID`.