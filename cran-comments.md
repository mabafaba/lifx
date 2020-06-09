## Test environments
* R 3.5.1, local OS X install
* R 3.6.3, local OS X install 
* R 4.0.0, Travis / Appveyor, x86_64-w64-mingw32/x64 (64-bit) under Windows Server 2012 R2 x64
* R-devel (r-hub) Fedora Linux, clang, gfortran
* R-devel (r-hub) Windows Server 2008 R2 SP1, 32/64 bit
* win-builder (devel & release)

## R CMD check results
* This is my *first submission*
* There were *no ERRORs, WARNINGs or NOTEs* (except the "new submission" Note)
* There was a message about possibly mis-spelled words in DESCRIPTION (LIFX (7:58), Lifx (3:17, 8:18)) which are spelled correctly.


## Downstream dependencies
* There are currently *no downstream dependencies* for this package


## Resubmission: changes
- Put non-English API name in *undirected* single quotes in title and description
- Fixed punctuation to only capitalize names, sentence beginnings and
abbreviations/acronyms in description
- added api link to DESCRIPTION file in the requested format
- added examples to all exported functions. Most functions require an API token, therefore are wrapped in \\dontrun{}
- added 'value' documentation to all functions except print methods
- lx_get_token() and lx_has_token() does not accept any arguments, therefore there are no \arguments Rd-tags
- removed print()/cat() from all functions (except in print methods and their non-exported helper functions. I moved the helper functions to print methods inside the print methods themselves to make their use only within the print method explicit.

## previous CRAN review comments

"Please always write non-English usage, package names, software names and
API names in *undirected* single quotes in title and description in the
DESCRIPTION file.

Please only capitalize names, sentence beginnings and
abbreviations/acronyms in the description text of your DESCRIPTION file.

Please add a web reference for this API in your Description field of the
DESCRIPTION file in the form
<http:...> or <https:...>
with angle brackets for auto-linking and no space after 'http:' and
'https:'.

Please add small executable examples in your Rd-files to illustrate the
use of the exported functions but also enable automatic testing.
When creating the examples please keep in mind that the structure
would be desirable:
\examples{
    examples for users and checks:
    executable in < 5 sec
    \dontshow{
        examples for checks:
        executable in < 5 sec together with the examples above
        not shown to users
    }
    \donttest{
        further examples for users; not used for checks
        (f.i. data loading examples, or time consuming functions )
    }
    \dontrun{
     not used by checks, not used by example()
     adds the comment ("# Not run:") as a warning for the user.
     cannot run (e.g. because of missing additional software,
     missing API keys, ...)
    }
    if(interactive()){
        functions not intended for use in scripts,
        or are supposed to only run interactively
        (f.i. shiny)
    }
}
Your users will appreciate to see how the function is supposed to be
called for tiny examples.

Please add \value to .Rd files regarding exported methods and explain
the functions results in the documentation. Please write about the
structure of the output (class) and also what the output means.
(If a function does not return a value, please document that too, e.g.
\value{No return value, called for side effects} or similar)

More missing Rd-tags:
      lx_get_token.Rd: \arguments
      lx_has_token.Rd: \arguments

You write information messages to the console that cannot be easily
suppressed.
It is more R like to generate objects that can be used to extract the
information a user is interested in, and then print() that object.
Instead of print()/cat() rather use message()/warning()  or
if(verbose)cat(..) if you really have to write text to the console.
(except for print, summary, interactive functions)"






