# Netrunnikiser

Sorry about the name.

This is a Ruby script for generating cards for Netrunnikers, a custom version of the party game Monikers. You could use it to create custom Monikers cards of any kind.

This script is provided as-is and is not really intended to be fully formed. Support will be minimal ;)

## Requirements

You'll need a recent(ish?) version of Ruby. 2.2 and up is probably fine.

It uses RMagick for image rendering which has its own requirements: https://github.com/rmagick/rmagick/tree/master

## Usage

Dive into `go.rb`. At the top are two variables: `folder` and `prefix`.

The `folder` should be the name of a folder in the root of the project. It should contain a CSV called `cards.csv`. An example is provided.

The `prefix` is an optional short prefix which will appear on the cards as part of the number code.

Once the folder and CSV are in place, run:

```
> ruby go.rb
```

The script will run. For each row in the CSV a numbered image of the generated card will be created in the specified folder.

Try running the script with folder set to `example` and looking at the image files in that folder. Try tweaking `cards.csv` and see the different files that are generated when you re-run the script.
