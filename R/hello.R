
#' Get or set Shiny options
#'
#' `getShinyOption()` retrieves the value of a Shiny option. `shinyOptions()`
#' sets the value of Shiny options; it can also be used to return a list of all
#' currently-set Shiny options.
#'
#' @section Scope:
#' There is a global option set which is available by default. When a Shiny
#' application is run with [runApp()], that option set is duplicated and the
#' new option set is available for getting or setting values. If options
#' are set from `global.R`, `app.R`, `ui.R`, or `server.R`, or if they are set
#' from inside the server function, then the options will be scoped to the
#' application. When the application exits, the new option set is discarded and
#' the global option set is restored.
#'
#' @section Options:
#' There are a number of global options that affect Shiny's behavior. These can
#' be set globally with `options()` or locally (for a single app) with
#' `shinyOptions()`.
#'
#' \describe{
#'   \item{shiny.autoreload (defaults to `FALSE`)}{If `TRUE` when a Shiny app is launched, the
#'     app directory will be continually monitored for changes to files that
#'     have the extensions: r, htm, html, js, css, png, jpg, jpeg, gif. If any
#'     changes are detected, all connected Shiny sessions are reloaded. This
#'     allows for fast feedback loops when tweaking Shiny UI.
#'
#'     Since monitoring for changes is expensive (we simply poll for last
#'     modified times), this feature is intended only for development.
#'
#'     You can customize the file patterns Shiny will monitor by setting the
#'     shiny.autoreload.pattern option. For example, to monitor only ui.R:
#'     `options(shiny.autoreload.pattern = glob2rx("ui.R"))`
#'
#'     The default polling interval is 500 milliseconds. You can change this
#'     by setting e.g. `options(shiny.autoreload.interval = 2000)` (every
#'     two seconds).}
#'   \item{shiny.deprecation.messages (defaults to `TRUE`)}{This controls whether messages for
#'     deprecated functions in Shiny will be printed. See
#'     [shinyDeprecated()] for more information.}
#' }
#' @param ... Options to set, with the form `name = value`.
#' @aliases shiny-options
#' @examples
#' \dontrun{
#' shinyOptions(myOption = 10)
#' getShinyOption("myOption")
#' }
#' @export
shinyOptions <- function(...) {
  newOpts <- list(...)

  if (length(newOpts) > 0) {
    .globals$options <- dropNulls(mergeVectors(.globals$options, newOpts))
    invisible(.globals$options)
  } else {
    .globals$options
  }
}

