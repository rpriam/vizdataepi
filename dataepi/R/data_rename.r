#' A function for renaming the modalities of categorical variables 
#'
#' This function take as input a data.frame and the names of the categorical 
#' variables in order to rename the modalities with strings.
#' 
#' @param A The data.frame with the variables to rename.
#' @param vars_disc_to_recode The vector with the string names of the 
#' variables to rename.
#' 
#' @return
#' \describe{
#'   \item{A}{A data.frame for the dataset after renaming the modalities.}
#'   \item{dico}{A list with the correspondences between the old and 
#'               new characters strings as modalities of the selected categorical variables.}
#' }
#' 
#' @keywords 
#' @export
#' @examples
#' data(DebTrivedi)
#' A <- DebTrivedi
#' A$id      <- 1:nrow(A)
#' A$hospbin <- as.integer(A$hosp>0)
#' var_id    = "id"
#' vars_cont = c("age","ofp","ofnp","opp","opnp","emer","numchron","hosp","school")
#' vars_disc = c("health","adldiff","region","black","gender","married","employed",
#'               "privins","medicaid")
#' vars_int  = NULL 
#' var_y     = "hospbin" #binary 0/1
#' label_y   = "hospibin"
#' A <- data_prepare(A,var_y,vars_cont,vars_disc,var_id)$A
#' vars_disc_to_recode  <- c("health","gender","region")
#' resu_     <- data_rename(A, vars_disc_to_recode) 
#' for (nv in vars_disc_to_recode) {
#'   resu_nv <-  data.frame(resu_$dico[[nv]])
#'   rownames(resu_nv) <- nv
#'   print(resu_nv)
#' }
#' 
data_rename <- function(A, vars_disc_to_recode) {#,underscore) {
  stopifnot(sum(vars_disc_to_recode%in%names(A))>0)
  dico=list()
  for (nv in vars_disc_to_recode) {
    lvs=unique(A[,nv])
    V_old = A[,nv]
    V_new = A[,nv]
    dico[[nv]]=list()
    cc=0
    for (l in lvs) {
      cc=cc+1      
      dico[[nv]][[l]] = as.character(cc)
      V_new[V_new==l] = as.character(cc)
    }
    A[,nv]=V_new
  }
  return(list(A=A,dico=dico))  
}

