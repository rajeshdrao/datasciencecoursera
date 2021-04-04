best <- function(state, outcome) {
  ## Read outcome data
  outcomedf <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  stateslist <- unique(outcomedf$State)
  outcomelist <- c('heart attack', 'heart failure',  'pneumonia')
  if(!(state %in% stateslist)){
    stop("invalid state")
  }
  
  if (!(outcome %in% outcomelist)){
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  staterecords <- subset(outcomedf, outcomedf$State == state, select=c("State","Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"))
  names(staterecords)[names(staterecords) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"] <- "HA"
  names(staterecords)[names(staterecords) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"] <- "Pneumonia"
  names(staterecords)[names(staterecords) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"] <- "HF"
  staterecords[,"HF"] <- as.numeric(staterecords[,"HF"])
  staterecords[,"Pneumonia"] <- as.numeric(staterecords[,"Pneumonia"])
  
  
  hospitallist <-switch(
    outcome,
    "heart attack"= subset(staterecords, staterecords$HA==min(staterecords$HA,na.rm = TRUE),select=c("Hospital.Name"))[order("Hospital.Name")],
    "heart failure"= subset(staterecords, staterecords$HF==min(staterecords$HF,na.rm = TRUE),select=c("Hospital.Name"))[order("Hospital.Name")],
    "pneumonia"= subset(staterecords, staterecords$Pneumonia==min(staterecords$Pneumonia,na.rm = TRUE),select=c("Hospital.Name")[order("Hospital.Name")])
           
  )
  hospitallist$Hospital.Name
  
}