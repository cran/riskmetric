#' A subclass wrapping an error with an additional parent class
#'
#' @param error an error condition object to capture
#'
#' @return an error condition object after wrap \code{pkg_metric_error} class.
#' @keywords internal
as_pkg_metric_error <- function(error) {
  as_pkg_metric_condition(error, subclass = "pkg_metric_error")
}



#' Error handler for assessments with safe fallback
#'
#' @inheritParams format_assessment_message
#' @param ... additional arguments unused
#'
#' @return a pkg_metric object of pkg_metric_error subclass
#'
#' @family assessment error handlers
#'
#' @export
assessment_error_empty <- function(e, ...) {
  as_pkg_metric_error(pkg_metric(e))
}



#' Error handler for assessments to throw error immediately
#'
#' @inheritParams format_assessment_message
#' @return the error encountered during assessment
#'
#' @family assessment error handlers
#'
#' @export
assessment_error_throw <- function(e, name, assessment) {
  stop(format_assessment_message(e, name, assessment))
}



#' Error handler for assessments to deescalate errors to warnings
#'
#' @inheritParams format_assessment_message
#' @inherit assessment_error_empty return
#'
#' @family assessment error handlers
#'
#' @export
assessment_error_as_warning <- function(e, name, assessment) {
  warning(format_assessment_message(e, name, assessment), call. = FALSE)
  assessment_error_empty(e)
}



#' Assessment console printing formatter
#'
#' make the errors and warnings consistent with meaningful indication of what
#' triggered the error, including the name of the package whose reference
#' triggered the error while running which asesessment.
#'
#' @param e an error raised during a package reference assessment
#' @param name the name of the package whose package reference assessment raised
#'   the error
#' @param assessment the name of the assessment function which raised the error
#' @return a character string of formatted text to communicate the error
#'
#' @importFrom utils capture.output
#' @keywords internal
format_assessment_message <- function(e, name, assessment) {
  out <- "In "

  if (!missing(name))
    out <- paste0(out, "package '", name, "' ")
  if (!missing(assessment))
    out <- paste0(out, "while assessing '", assessment, "' ")

  paste0(out,
    "`", paste(utils::capture.output(e$call), collapse = " "), "` : \n",
    e$message)
}



#' @importFrom pillar pillar_shaft new_pillar_shaft_simple style_na
#' @method pillar_shaft pkg_metric_error
#' @export
pillar_shaft.pkg_metric_error <- function(x, ...) {
  pillar::new_pillar_shaft_simple(pillar::style_na(paste0(
    "<",
    gsub("pkg_metric_", "", class(x)[[1]]),
    ">")))
}
