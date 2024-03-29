% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkg_score.R
\name{roxygen_score_family}
\alias{roxygen_score_family}
\title{Helper for creating a roxygen header from template for score.* functions}
\usage{
roxygen_score_family(name, dontrun = TRUE)
}
\arguments{
\item{name}{the name of the scoring function, assuming naming conventions are
followed}

\item{dontrun}{logical indicating whether examples should be wrapped in
a dontrun block. This is particularly useful for assessments which may
require an internet connection.}
}
\value{
roxygen section template for score family functions
}
\description{
Helper for creating a roxygen header from template for score.* functions
}
\examples{
\dontrun{
#' @eval roxygen_score_family("has_news")
}
}
\keyword{internal}
