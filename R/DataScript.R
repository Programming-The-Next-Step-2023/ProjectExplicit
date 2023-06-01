

# AUDIT_Quest --------------------------------------------------------------

### Generate AUDIT Questionnaire .rda Data file ###

#AUDIT Questions
AUDIT_Q1 <- "How often do you have a drink containing alcohol?"
AUDIT_Q2 <- "How many drinks do you have on a typical day when you are drinking?"
AUDIT_Q3 <- "How often do you have 6 or more drinks on one occasion?"
AUDIT_Q4 <- "How often during the last year have you found that you were not able to stop drinking once you had started?"
AUDIT_Q5 <- "How often during the last year have you failed to do what was normally expected from you because of drinking?"
AUDIT_Q6 <- "How often during the last year have you needed a first drink in the morning to get yourself going after a heavy drinking session?"
AUDIT_Q7 <- "How often during the last year have you had a feeling of guilt or remorse after drinking?"
AUDIT_Q8 <- "How often during the last year have you been unable to remember what happened the night before because you had been drinking?"
AUDIT_Q9 <- "Have you or someone else been injured as a result of your drinking?"
AUDIT_Q10 <- "Has a relative or friend, or a doctor or other health worker been concerned about your drinking or suggested you cut down?"

#AUDIT Answer Choices
AUDIT_Ans_1 <- c("Never",
                 "Monthly or less",
                 "2 to 4 times a month",
                 "2 to 3 times per week",
                 "4 or more times per week")
AUDIT_Ans_2 <- c("1 or 2",
                 "3 or 4",
                 "5 or 6",
                 "7 or 9",
                 "10 or more")
AUDIT_Ans_3_8 <- c("Never",
                   "Less than Monthly",
                   "Monthly",
                   "Weekly",
                   "Daily or almost daily")
AUDIT_Ans_9_10 <- c("No",
                    "Yes, but not in the last year",
                    "Yes, during the last year",
                    NA,
                    NA)

#Combine into a Dataframe
AUDIT_Qs <- matrix(c(AUDIT_Q1, AUDIT_Q2, AUDIT_Q3, AUDIT_Q4, AUDIT_Q5, AUDIT_Q6, AUDIT_Q7, AUDIT_Q8, AUDIT_Q9, AUDIT_Q10), nrow=1)
AUDIT_Ans <- matrix(c(AUDIT_Ans_1, AUDIT_Ans_2, rep(AUDIT_Ans_3_8, 6), rep(AUDIT_Ans_9_10, 2)), nrow=5)
AUDIT <- rbind(AUDIT_Qs, AUDIT_Ans)
colnames(AUDIT) <- c(paste(rep("Q", 10), 1:10, sep=""))
AUDIT <- as.data.frame(t(AUDIT))
colnames(AUDIT) <- c("Question", paste(rep("Answer_",5), 1:5, sep=""))

#Make Package Data
usethis::use_data(AUDIT, overwrite = TRUE)


# DASS21_Quest ------------------------------------------------------------

### Generate DASS-21 Questionnaire .rda Data file ###

#DASS-21 Questions
DASS_Q1 <- "I found it hard to wind down."
DASS_Q2 <- "I was aware of dryness of my mouth."
DASS_Q3 <- "I could not seem to experience any positive feeling."
DASS_Q4 <- "I experienced breathing difficulty."
DASS_Q5 <- "I found it difficult to work up the initiative"
DASS_Q6 <- "I tended to over-react to situations"
DASS_Q7 <- "I experienced trembling"
DASS_Q8 <- "I felt I was using a lot of nervous energy"
DASS_Q9 <- "I was worried about situations in which I might panic and make a fool of myself"
DASS_Q10 <- "I felt that I had nothing to look forward to"
DASS_Q11 <- "I found myself getting agitated"
DASS_Q12 <- "I found it difficult to relax"
DASS_Q13 <- "I felt down-hearted and blue"
DASS_Q14 <- "I was intolerant of anything that kept me from getting on with what I was doing"
DASS_Q15 <- "I felt I was close to panic"
DASS_Q16 <- "I was unable to become enthusiastic about anything"
DASS_Q17 <- "I felt I was not worth much as a person"
DASS_Q18 <- "I felt that I was rather touchy"
DASS_Q19 <- "I was aware of the action of my heart in the absence of physical exertion"
DASS_Q20 <- "I felt scared without any good reason"
DASS_Q21 <- "I felt that life was meaningless"




#DASS Answer Choices
DASS_Ans <- c("Did not apply to me at all",
              "Sometimes applied to me",
              "Frequently applied to me",
              "Applied to me very much")

#Combine into a Dataframe

DASS_Qs <- matrix(c(DASS_Q1, DASS_Q2, DASS_Q3, DASS_Q4, DASS_Q5, DASS_Q6, DASS_Q7, DASS_Q8, DASS_Q9, DASS_Q10, DASS_Q11, DASS_Q12, DASS_Q13, DASS_Q14, DASS_Q15, DASS_Q16, DASS_Q17, DASS_Q18, DASS_Q19, DASS_Q20, DASS_Q21), nrow=1)
DASS_Ans <- matrix(c(rep(DASS_Ans, 21)), nrow=4)
DASS <- rbind(DASS_Qs, DASS_Ans)
colnames(DASS) <- c(paste(rep("Q", 21), 1:21, sep=""))
DASS <- as.data.frame(t(DASS))
colnames(DASS) <- c("Question", paste(rep("Answer_",4), 1:4, sep=""))


#Make Package Data
usethis::use_data(DASS, overwrite=TRUE)
