## Resubmission
Thank you for your time & feedback.

Last recieved feedback:

1. There was an unexported function with example.

  - The function is now exported

2. Most functions' examples were set to "dontrun{}". It was recommended to let them run or to add unit tests.

  - Most functions require an API key in order to run examples and tests. For those, I have done the following:
  - \dontrun{} examples
  - unit test are now available, but they are skipped if no token is available (with testthat::skip()).
  - Here is a list of all functions and how their examples / tests are handled now:
    - Examples run;  added unit tests:
        - lx_selector
    - Examples require api key, therefore keeping dontrun, but added unit tests:
        - lx_color_name
        - lx_get_token
    - Examples run. Function too simple for meaningful unit tests (single line of code):
        - lx_has_token
    - Examples require api token, therefore dontrun; unit tests exist but are skipped unless an api key is available:
        - lx_check_color    
        - lx_color        
        - lx_toggle
        - lx_effect_breathe
        - lx_effect_flame  
        - lx_effect_morph   
        - lx_effect_move   
        - lx_effect_off    
        - lx_effect_pulse   
        - lx_list_lights
        - lx_rate_limit
    - Examples would change/overwrite a environmental variable, therefore dontrun. Too simple for meaningful unit tests:
        - lx_save_token



## Previous Resubmissions: 
- Put non-English API name in *undirected* single quotes in title and description
- Fixed punctuation in DESCRIPTION description so that only names, sentence beginnings and
abbreviations/acronyms are capitalised
- added api link to DESCRIPTION file in the requested format
- added examples to all exported functions. Most functions require an API token, therefore are wrapped in \dontrun{}
- added 'value' documentation to all functions except print methods
- simplified return object of lx_list_lights() with more detailed description of the structure & content of the returned object.
- removed print()/cat() from all functions (except in print methods and their non-exported helper functions that are only used within the print methods themselves).
- lx_get_token() and lx_has_token() do not accept any arguments, therefore there are no \arguments Rd-tags

## Test environments
* R 3.5.1, local OS X install
* R 3.6.3, local OS X install 
* R 4.0.0, Travis / Appveyor, x86_64-w64-mingw32/x64 (64-bit) under Windows Server 2012 R2 x64
* R-devel (r-hub) Fedora Linux, clang, gfortran
* R-devel (r-hub) Windows Server 2008 R2 SP1, 32/64 bit
* win-builder (devel & release)

## R CMD check results
* This is my *first submission* (resubmitting after review)
* There were *no ERRORs, WARNINGs or NOTEs* (except the "new submission" Note)


## Downstream dependencies
* There are currently *no downstream dependencies* for this package

## Previous submission CRAN review comments as recieved:

### First submission 
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






