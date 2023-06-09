#  File src/library/stats/R/ks.test.R
#  Part of the R package, https://www.R-project.org
#
#  Copyright (C) 1995-2022 The R Core Team
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  https://www.R-project.org/Licenses/

ks.test <- function(x, ...) UseMethod("ks.test")

ks.test.default <-
    function(x, y, ..., alternative = c("two.sided", "less", "greater"),
             exact = NULL, simulate.p.value = FALSE, B = 2000)
{
    alternative <- match.arg(alternative)
    DNAME <- deparse1(substitute(x))
    x <- x[!is.na(x)]
    n <- length(x)
    if(n < 1L)
        stop("not enough 'x' data")
    PVAL <- NULL

    ### ordered variables can be treated as numeric ones as ties are handled
    ### now
    if (is.ordered(y)) y <- unclass(y)

    if(is.numeric(y)) { ## two-sample case
        args <- list(...)
        if (length(args) > 0L) 
            warning("Parameter(s) ", paste(names(args), collapse = ", "), " ignored")
        DNAME <- paste(DNAME, "and", deparse1(substitute(y)))
        y <- y[!is.na(y)]
        n.x <- as.double(n)             # to avoid integer overflow
        n.y <- length(y)
        if(n.y < 1L)
            stop("not enough 'y' data")
        if(is.null(exact))
            exact <- (n.x * n.y < 10000)
        if (!simulate.p.value) {
            METHOD <- paste(c("Asymptotic", "Exact")[exact + 1L], 
                            "two-sample Kolmogorov-Smirnov test")
        } else {
            METHOD <- "Monte-Carlo two-sample Kolmogorov-Smirnov test"
        }
        TIES <- FALSE
        n <- n.x * n.y / (n.x + n.y)
        w <- c(x, y)
        z <- cumsum(ifelse(order(w) <= n.x, 1 / n.x, - 1 / n.y))
        if(length(unique(w)) < (n.x + n.y)) {
            z <- z[c(which(diff(sort(w)) != 0), n.x + n.y)]
            TIES <- TRUE
            if (!exact && !simulate.p.value)
                warning("p-value will be approximate in the presence of ties")
        }
        STATISTIC <- switch(alternative,
                            "two.sided" = max(abs(z)),
                            "greater" = max(z),
                            "less" = - min(z))
        nm_alternative <- switch(alternative,
                                 "two.sided" = "two-sided",
                                 "less" = "the CDF of x lies below that of y",
                                 "greater" = "the CDF of x lies above that of y")
        z <- NULL
        if (TIES)
            z <- w
        PVAL <- switch(alternative,
            "two.sided" = psmirnov(STATISTIC, sizes = c(n.x, n.y), z = w, exact = exact, 
                                   simulate = simulate.p.value, B = B,
                                   lower.tail = FALSE),
            "less" = psmirnov(STATISTIC, sizes = c(n.x, n.y), , z = w, exact = exact,
                              simulate = simulate.p.value, B = B,
                              two.sided = FALSE, lower.tail = FALSE),
            "greater" = psmirnov(STATISTIC, sizes = c(n.x, n.y), , z = w, exact = exact,
                                 simulate = simulate.p.value, B = B,
                                 two.sided = FALSE, lower.tail = FALSE))
        ### match MC p-values to those reported by chisq.test
        if (simulate.p.value) PVAL <- (1 + (PVAL * B)) / (B + 1)
    } else { ## one-sample case
        if(is.character(y)) # avoid matching anything in this function
            y <- get(y, mode = "function", envir = parent.frame())
        if(!is.function(y))
            stop("'y' must be numeric or a function or a string naming a valid function")
        TIES <- FALSE
        if(length(unique(x)) < n) {
            warning("ties should not be present for the Kolmogorov-Smirnov test")
            TIES <- TRUE
        }
        if(is.null(exact)) exact <- (n < 100) && !TIES
        METHOD <- paste(c("Asymptotic", "Exact")[exact + 1L], 
                        "one-sample Kolmogorov-Smirnov test")
        x <- y(sort(x), ...) - (0 : (n-1)) / n
        STATISTIC <- switch(alternative,
                            "two.sided" = max(c(x, 1/n - x)),
                            "greater" = max(1/n - x),
                            "less" = max(x))
        if(exact) {
            PVAL <- 1 - if(alternative == "two.sided")
                .Call(C_pKolmogorov2x, STATISTIC, n)
            else {
                pkolmogorov1x <- function(x, n) {
                    ## Probability function for the one-sided
                    ## one-sample Kolmogorov statistics, based on the
                    ## formula of Birnbaum & Tingey (1951).
                    if(x <= 0) return(0)
                    if(x >= 1) return(1)
                    j <- seq.int(from = 0, to = floor(n * (1 - x)))
                    1 - x * sum(exp(lchoose(n, j)
                                    + (n - j) * log(1 - x - j / n)
                                    + (j - 1) * log(x + j / n)))
                }
                pkolmogorov1x(STATISTIC, n)
            }
        } else {
            PVAL <- if(alternative == "two.sided")
                        1 - .Call(C_pKS2, sqrt(n) * STATISTIC, tol = 1e-6)
                    else exp(- 2 * n * STATISTIC^2)
        }
        nm_alternative <-
            switch(alternative,
                   "two.sided" = "two-sided",
                   "less" = "the CDF of x lies below the null hypothesis",
                   "greater" = "the CDF of x lies above the null hypothesis")
    }

    names(STATISTIC) <- switch(alternative,
                               "two.sided" = "D",
                               "greater" = "D^+",
                               "less" = "D^-")

    ## fix up possible overshoot (PR#14671)
    PVAL <- min(1.0, max(0.0, PVAL))
    RVAL <- list(statistic = STATISTIC,
                 p.value = PVAL,
                 alternative = nm_alternative,
                 method = METHOD,
                 data.name = DNAME,
                 data = list(x = x, y = y), # FIXME confband
                 exact = exact)             # FIXME confband
    class(RVAL) <- c("ks.test", "htest")
    return(RVAL)
}

ks.test.formula <-
function(formula, data, subset, na.action, ...)
{
    if(missing(formula) || (length(formula) != 3L))
        stop("'formula' missing or incorrect")
    oneSample <- FALSE
    if (length(attr(terms(formula[-2L]), "term.labels")) != 1L)
        if (formula[[3L]] == 1L)
            oneSample <- TRUE
        else
            stop("'formula' missing or incorrect")
    m <- match.call(expand.dots = FALSE)
    if (is.matrix(eval(m$data, parent.frame())))
        m$data <- as.data.frame(data)
    ## need stats:: for non-standard evaluation
    m[[1L]] <- quote(stats::model.frame)
    m$... <- NULL
    mf <- eval(m, parent.frame())
    rname <- names(mf)[1L]
    DNAME <- paste(names(mf), collapse = " by ") # works in all cases
    names(mf) <- NULL
    response <- attr(attr(mf, "terms"), "response")
    if (! oneSample) { # Smirnov test
        g <- factor(mf[[-response]])
        if(nlevels(g) != 2L)
            stop("grouping factor must have exactly 2 levels")
        DATA <- split(mf[[response]], g)
        ## Call the default method.
        y <- ks.test(x = DATA[[1L]], y = DATA[[2L]], ...)        
        y$alternative <- gsub("x", levels(g)[1L], y$alternative)
        y$alternative <- gsub("y", levels(g)[2L], y$alternative)
        y$response <- rname             # FIXME confband
        y$groups <- levels(g)           # FIXME confband
    }
    else { # one-sample test
        respVar <- mf[[response]]
        ## Call the default method.
        y <- ks.test(x = respVar, ...)
        y$alternative <- gsub("x", DNAME, y$alternative)
    }
    y$data.name <- DNAME
    y
}

rsmirnov <- 
function(n, sizes, z = NULL, two.sided = TRUE) {

    if (n < 0)
        stop("invalid arguments")
    if (n == 0L) return(numeric(0))
    n <- floor(n)

    if (length(sizes) != 2L)
        stop("argument 'sizes' must be a vector of length 2") 
    n.x <- sizes[1L]
    n.y <- sizes[2L]
    if (n.x < 1) stop("not enough 'x' data")
    if (n.y < 1) stop("not enough 'y' data")
    n.x <- floor(n.x)
    n.y <- floor(n.y)

    if (is.null(z)) {
        rt <- rep.int(1, n.x + n.y)
    } else {
        rt <- table(z)
    }
    ret <- .Call(C_Smirnov_sim,
                 as.integer(rt),
                 as.integer(c(n.x, n.y)),
                 as.integer(n),
                 as.integer(two.sided))
    return(ret)
}

psmirnov_exact <-
function(q, sizes, z = NULL,
         two.sided = TRUE, lower.tail = TRUE, log.p = FALSE) {
    if(!is.null(z)) {
        z <- (diff(sort(z)) != 0)
        z <- if(any(z))
            c(0L, z, 1L)
        else
            NULL
    }
    p <- .Call(C_psmirnov_exact, q, sizes[1L], sizes[2L], z,
               two.sided, lower.tail)
    if(log.p)
        p <- log(p)
    p
}

psmirnov_asymp <-
function(q, sizes,
         two.sided = TRUE, lower.tail = TRUE, log.p = FALSE) {
    n <- prod(sizes) / sum(sizes)
    ## <FIXME>
    ## Let m and n be the min and max of the sample sizes, respectively.
    ## Then, according to Kim and Jennrich (1973), if m < n/10, we
    ## should use the 
    ## * Kolmogorov approximation with c.c. -1/(2*n) if 1 < m < 80;
    ## * Smirnov approximation with c.c. 1/(2*sqrt(n)) if m >= 80.
    if (two.sided) {
        ret <- .Call(C_pKS2, p = sqrt(n) * q, tol = 1e-6)
        ## note: C_pKS2(0) = NA but Prob(D < 0) = 0
        ret[q < .Machine$double.eps] <- 0
    } else {
        ret <- 1 - exp(- 2 * n * q^2)
    }
    if(log.p) {
        if(lower.tail)
            log(ret)
        else
            log1p(-ret)
    } else {
        if(lower.tail)
            ret
        else
            1 - ret
    }
}

psmirnov_simul <-
function(q, sizes, z = NULL,
         two.sided = TRUE, lower.tail = TRUE, log.p = FALSE,
         B) {
    Dsim <- rsmirnov(B, sizes = sizes, z = z, two.sided = two.sided)
    ## need P(D < q)
    ret <- ecdf(Dsim)(q - sqrt(.Machine$double.eps)) 
    if(log.p) {
        if(lower.tail)
            log(ret)
        else
            log1p(-ret)
    } else {
        if(lower.tail)
            ret
        else
            1 - ret
    }
}   

psmirnov <-
function(q, sizes, z = NULL, two.sided = TRUE,
         exact = TRUE, simulate = FALSE, B = 2000,
         lower.tail = TRUE, log.p = FALSE) {

    ##
    ## Distribution function Prob(D < q) for the Smirnov test statistic
    ##
    ##   D = sup_c | ECDF_x(c) - ECDF_y(c) | 	(two.sided)
    ##
    ##   D = sup_c ( ECDF_x(c) - ECDF_y(c) ) 	(!two.sided)
    ##
    ## See
    ##     
    ##   Gunar Schröer and Dietrich Trenkler (1995),
    ##   Exact and Randomization Distributions of Kolmogorov-Smirnov
    ##   Tests for Two or Three Samples,
    ##   Computational Statistics & Data Analysis, 20, 185--202

    if (is.numeric(q)) 
        q <- as.double(q)
    else stop("argument 'q' must be numeric")
    ret <- rep.int(0, length(q))
    ret[is.na(q) | q < -1 | q > 1] <- NA
    IND <- which(!is.na(ret))
    if (!length(IND)) return(ret)

    if (length(sizes) != 2L)
        stop("argument 'sizes' must be a vector of length 2") 
    n.x <- sizes[1L]
    n.y <- sizes[2L]
    if (n.x < 1) stop("not enough 'x' data")
    if (n.y < 1) stop("not enough 'y' data")
    n.x <- floor(n.x)
    n.y <- floor(n.y)
    N <- n.x + n.y
    n <- n.x * n.y / (n.x + n.y)

    ### always return MC prob when asked to
    exact <- exact && !simulate

    if (!exact) {
        ret[IND] <-
            if (simulate)
                psmirnov_simul(q[IND], sizes, z,
                               two.sided, lower.tail, log.p,
                               B)
            else
                psmirnov_asymp(q[IND], sizes,
                               two.sided, lower.tail, log.p)
        return(ret)
    }

    pfun <- function(q)
        psmirnov_exact(q, sizes, z, two.sided, lower.tail, log.p)

    ret[IND] <- vapply(q[IND], pfun, 0)
    if (any(!is.finite(ret[IND]))) {
        warning("computation of exact probability failed, returning Monte Carlo approximation")
        ret[IND] <-
            psmirnov_simul(q[IND], sizes, z,
                           two.sided, lower.tail, log.p,
                           B)
        return(ret)
    }

    ret
}

qsmirnov <-
function(p, sizes, z = NULL, two.sided = TRUE,
         exact = TRUE, simulate = FALSE, B = 2000)
{
    n.x <- floor(sizes[1L])
    n.y <- floor(sizes[2L])
    if (n.x * n.y < 1e4) {
        ### note: The support is also OK in case of ties
        stat <- sort(unique(c(outer(0:n.x/n.x, 0:n.y/n.y, "-"))))
    } else {
        stat <- (-1e4):1e4 / (1e4 + 1)
    }
    if (two.sided) stat <- abs(stat)
    prb <- psmirnov(stat, sizes = sizes, z = z, two.sided = two.sided,
                    exact = exact, simulate = simulate, B = B,
                    log.p = FALSE, lower.tail = TRUE)
    if (is.null(p)) return(list(stat = stat, prob = prb))
    if (is.numeric(p)) 
        p <- as.double(p)
    else stop("argument 'p' must be numeric")
    ret <- rep.int(0, length(p))
    ret[is.na(p) | p < 0 | p > 1] <- NA
    IND <- which(!is.na(ret))
    if (!length(IND)) return(ret)
    ret[IND] <- sapply(p[IND], function(u) min(stat[prb >= u]))
    ret
}

