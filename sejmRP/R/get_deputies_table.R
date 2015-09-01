#' Importing deputies table from a database
#'
#' Function \code{get_deputies_table} imports deputies table from a database.
#' 
#' @usage get_deputies_table(dbname = 'sejmrp', user = 'reader', password = 'qux94874', 
#' host = 'services.mini.pw.edu.pl', sorted_by_id = TRUE)
#'
#' @param dbname name of database; default: 'sejmrp'
#' @param user name of user; default: 'reader'
#' @param password password of database; default: 'qux94874'
#' @param host name of host; default: 'services.mini.pw.edu.pl'
#' @param sorted_by_id information if table should be sorted by id; default: TRUE
#'
#' @return data frame
#'
#' @examples
#' \dontrun{
#' deputies <- get_deputies_table()
#' dim(deputies)
#' # [1] 512   2
#' names(deputies)
#' # [1] "id_deputy"    "surname_name"}
#' 
#' @note
#' Default parameters use privilages of 'reader'. It can only SELECT data from database.
#' 
#' All information is stored in PostgreSQL database.
#'
#' @author Piotr Smuda
#' 
#' @export
#'

get_deputies_table <- function(dbname = 'sejmrp', user = 'reader', password = 'qux94874', 
  host = 'services.mini.pw.edu.pl', sorted_by_id = TRUE){
  stopifnot(is.character(dbname),is.character(user),is.character(password),
            is.character(host))
  
  #connecting to database
  drv <- dbDriver("PostgreSQL")
  database_diet <- dbConnect(drv,dbname=dbname,user=user,password=password,host=host)
  
  #reading table
  if(sorted_by_id){
  deputies <- dbGetQuery(database_diet,"SELECT * FROM deputies ORDER BY id_deputy")
  }
  else{
  deputies <- dbGetQuery(database_diet,"SELECT * FROM deputies")
  }
  
  return(deputies)
}