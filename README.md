
# portal

<!-- badges: start -->
<!-- badges: end -->

Move R datasets between local sessions.

## Installation

You can install the development version of portal from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("milesmcbain/portal")
```

## Usage

You discovered a problem in your pipeline. You you have the data but the code that's blowing up lives in one of your packages. You fire up the package project and prepare to get cracking... but geez woulnd't it be nice if you could just pull that dataset from your pipeline, directly into your package REPL?

I mean reprexes are nice and all... but a dataset that creates the issue is right there...

## Pipeline R session 

```R
❯ breaking_dataset |> portal::push()

#                      __
#                     |  |---
#                     |  |
# breaking_dataset -> |  |
#                     |  |
#                     |__|--- 

```

## Package session

```R
❯ portal::pull()
#     __
# ---|  |
#    |  |
#    |  | -> breaking_dataset
#    |  |
# ---|__|

```

`breaking_dataset` is now in the global environment. Let's get fixing!

## Advanced usage

By default datasets are serialised using Rds. If that's too slow `push` takes a `serialiser` argument which can be set as an option: `portal.serialser`. Supported choices are in `c("rds", "qs", "parquet")`.

## Problems

`push()` uses the name of symbol you passed in to name the file, which in turn informs `pull` what to call the object when it is imported. Weird object names won't work that well. Notably if you use this with the `{magrittr}` pipe you'll have a bad time, since the symbol (and file) will be named `.`.

Similarly pushing unnamed expressions might result in invalid file names and so won't work. For now this might be useful:

I'll probably fix these eventually. Contributions are welcome.
