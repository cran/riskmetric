% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkg_ref_cache.R
\name{pkg_ref_cache}
\alias{pkg_ref_cache}
\title{S3 generic to calculate a `pkg_ref` field}
\value{
a \code{pkg_ref} field
}
\description{
Reactively retrieve and cache `pkg_ref` metadata
}
\section{Caching Details}{

\subsection{\code{pkg_ref} class fields}{
  The \code{pkg_ref} class structures an environment with special handling
  for indexing into the \code{pkg_ref} class using the \code{$} or \code{[[}
  operators. For all intents and purposes, the \code{pkg_ref} class is works
  conceptually similar to a lazy, immutable \code{list}, and uses the
  \code{pkg_ref_cache} function internally to lazily retrieve package
  reference fields.
}
\subsection{Lazy metadata caching}{
  Laziness in a \code{pkg_ref} object refers to the delayed evaluation of the
  contents of its fields. Since some metadata is time or computationally
  intensive to retrieve, and unnessary for some assessments, we want to avoid
  that retrieval until it is needed.

  The first time that a field is accessed within a \code{pkg_ref} object
  \code{x}, a corresponding \code{pkg_ref_cache} S3 generic is called. For
  example, when \code{x$description} is first accessed, the \code{pkg_ref}
  object uses the function \code{pkg_ref_cache.description} to attempt to
  retrieve the contents of the corresponding \code{DESCRIPTION} file.

  Often, the way that this data is collected might be different depending on
  the subclass of the \code{pkg_ref}. In the case of the \code{description}
  metadata, a reference to a local install might be able to read in a local
  file directly, whereas a reference to a remote source of metadata might
  require first downloading the file. For this reason, many
  \code{pkg_ref_cache.*} functions are themselves S3 generics that dispatch
  on the class of the \code{pkg_ref} object, allowing for divergent behaviors
  for different source of package metadata.
}
\subsection{\code{pkg_ref} field immutability}{
  Once a field has been calculated, its value is immutable. This behavior was
  chosen because of the long time frame over which package metadata changes,
  rendering it unnecessary to continually reevaluate fields each time they
  are accesssed.

  This means that within an assessment, a given field for a package will only
  ever be calculated once and preserved for downstream use.
}
}

\examples{
\dontrun{
# implementing a new field called "first_letter" that is consistently derived
# across all pkg_ref objects:

  pkg_ref_cache.first_letter <- function(x, name, ...) {
    substring(x$name, 1, 1)
  }

  x <- pkg_ref("riskmetric")
  x$first_letter



# implementing a new field called "subclass_enum" that dispatches on
# the subclass of the pkg_ref object:

  pkg_ref_cache.subclass_enum <- function(x, name, ...) {
    UseMethod("pkg_ref_cache.subclass_enum")
  }

  pkg_ref_cache.subclass_enum.pkg_ref <- function(x, name, ...) {
    0
  }

  pkg_ref_cache.subclass_enum.pkg_install <- function(x, name, ...) {
    1
  }

  x$subclass_enum
}

}
