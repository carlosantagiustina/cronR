#' Save the current crontab
#' 
#' @param file The file location at which you wish to save your
#'   \code{crontab}.
#' @param overwrite logical; should we overwrite the file at path \code{file}
#'   if it already exists?
#' @param user The user whose cron jobs we will be saving.
#' @export
#' @seealso \code{\link{file.copy}}
#' @examples 
#' \dontrun{
#' cron_add(command = cron_rscript(system.file(package = "cronR", "extdata", "helloworld.R")), 
#'   frequency = 'minutely', id = 'test1', description = 'My process 1')
#' cron_save(file="crontab_backup", overwrite=TRUE)
#' cron_clear()
#' cron_load(file="crontab_backup")
#' }
cron_save <- function(file, overwrite=FALSE, user="") {
  crontab <- parse_crontab(user=user)
  tempfile <- tempfile()
  on.exit( unlink(tempfile) )
  cat( deparse_crontab(crontab), "\n", file=tempfile)
  if (file.copy(tempfile, file, overwrite=overwrite)) {
    message("Saved crontab to file: ", normalizePath(file))
    return(TRUE)
  } else {
    message("Unable to save crontab to file!")
    return(FALSE)
  }
}
