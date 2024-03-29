% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drop.r
\name{drop}
\alias{drop}
\alias{hql_drop_dataset}
\alias{hql_drop_group}
\alias{hql_drop_attribute}
\alias{hql_drop_all_attributes}
\title{Drop HDF objects.}
\usage{
drop(what = c("FILE", "GROUP", "DATASET", "ATTRIBUTE"), path)

hql_drop_dataset(dataset)

hql_drop_group(group, recursive = FALSE)

hql_drop_attribute(attribute)

hql_drop_all_attributes(path)
}
\arguments{
\item{path}{The HDF dataset or group.}

\item{dataset}{The dataset to drop.}

\item{group}{The group to drop.}

\item{recursive}{If \code{TRUE}, drop all child groups and datasets.}

\item{attribute}{The attribute to drop.}
}
\description{
Drop HDF objects.
}
\section{Functions}{
\itemize{
\item \code{hql_drop_dataset()}: Drop HDF dataset.

\item \code{hql_drop_group()}: Drop HDF group.

\item \code{hql_drop_attribute()}: Drop HDF attribute.

\item \code{hql_drop_all_attributes()}: Drop all attributes from an HDF dataset or group.

}}
\keyword{internal}
