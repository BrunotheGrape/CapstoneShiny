
#

library(shiny)
library(quanteda); library(data.table); library(ggplot2)
library(dplyr); library(stringr); library(RColorBrewer)
library(tm); library(stringi)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$txt2 <- renderPrint({input$txt1
    req(input$txt1)
    p <- input$txt1
    p <- gsub("[^[:alpha:][:space:]']", " ", p)
    p <- gsub("'", "", p)
    p <- tail(strsplit(p,split=" ")[[1]],5)
    p <- paste(p, sep = " ", collapse = " ")
   
  
  p5 <- t(as.data.frame(strsplit(p, " ", fixed = TRUE)))
  p5 <- as.data.frame(p5)
  p5 <- select(p5, -V1)
  p5[] <- lapply(p5, as.character)
  p5$p <- paste(p5, sep = " ", collapse = ' ')

  p4 <- t(as.data.frame(strsplit(p5$p, " ", fixed = TRUE)))
  p4 <- as.data.frame(p4)
  p4 <- select(p4, -V1)
  p4[] <- lapply(p4, as.character)
  p4$p <- paste(p4, sep = ' ', collapse = ' ')

  p3 <- t(as.data.frame(strsplit(p4$p, " ", fixed = TRUE)))
  p3 <- as.data.frame(p3)
  #p3 <- select(p3, -V1)
  p3[] <- lapply(p3, as.character)
  p3$p <- paste(p3, sep = ' ', collapse = ' ')

  p2 <- t(as.data.frame(strsplit(p3$p, " ", fixed = TRUE)))
  p2 <- as.data.frame(p2)
  #p2 <- select(p2, -V1)
  p2[] <- lapply(p2, as.character)
  p2$p <- paste(p2, sep = ' ', collapse = ' ')

  p5 <- p5$p
  p4 <- p4$p
  p3 <- p3$p
  p2 <- p2$p

  # FtN6 <- read.csv("FtN6.csv")
  # PredN6 <- filter(FtN6, PRED == p)
  # PredN6 <- mutate(PredN6, WtFreq = Frequency/sum(PredN6$Frequency))
  #
  # FtN5 <- read.csv("FtN5.csv")
  # PredN5 <- filter(FtN5, PRED == p)
  # Pred1N5 <- filter(FtN5, PRED == p5)
  # PredN5 <- rbind(PredN5, Pred1N5)
  # PredN5 <- mutate(PredN5, WtFreq = Frequency/sum(PredN5$Frequency))

  FtN4 <- read.csv("FtN4.csv")
  PredN4 <- filter(FtN4, PRED == p)
  Pred1N4 <- filter(FtN4, PRED == p5)
  Pred2N4 <- filter(FtN4, PRED == p4)
  PredN4 <- rbind(PredN4, Pred1N4, Pred2N4)
  PredN4 <- mutate(PredN4, WtFreq = Frequency/sum(PredN4$Frequency))

  FtN3 <- read.csv("FtN3.csv")
  PredN3 <- filter(FtN3, PRED == p)
  Pred1N3 <- filter(FtN3, PRED == p5)
  Pred2N3 <- filter(FtN3, PRED == p4)
  Pred3N3 <- filter(FtN3, PRED == p3)
  PredN3 <- rbind(PredN3, Pred1N3, Pred2N3, Pred3N3)
  PredN3 <- mutate(PredN3, WtFreq = Frequency/sum(PredN3$Frequency))

  FtN2 <- read.csv("FtN2.csv")
  PredN2 <- filter(FtN2, PRED == p)
  Pred1N2 <- filter(FtN2, PRED == p5)
  Pred2N2 <- filter(FtN2, PRED == p4)
  Pred3N2 <- filter(FtN2, PRED == p3)
  Pred4N2 <- filter(FtN2, PRED == p2)
  PredN2 <- rbind(PredN2, Pred1N2, Pred2N2, Pred3N2, Pred4N2)
  PredN2 <- mutate(PredN2, WtFreq = Frequency/sum(PredN2$Frequency))

  FtN1 <- read.csv("FtN1.csv")
  #PredN6Wrd <- select(PredN6, txt6, WtFreq )
  #colnames(PredN6Wrd) <- c("Wrd", "WtFreq")
  #PredN5Wrd <- select(PredN5, txt5, WtFreq )
  #colnames(PredN5Wrd) <- c("Wrd", "WtFreq")
  PredN4Wrd <- select(PredN4, txt4, WtFreq )
  colnames(PredN4Wrd) <- c("Wrd", "WtFreq")
  PredN3Wrd <- select(PredN3, txt3, WtFreq )
  colnames(PredN3Wrd) <- c("Wrd", "WtFreq")
  PredN2Wrd <- select(PredN2, txt2, WtFreq )
  colnames(PredN2Wrd) <- c("Wrd", "WtFreq")

  #
  #
  # PredWrd <- rbind(PredN6Wrd,PredN5Wrd)
  # PredWrd <- rbind(PredWrd, PredN4Wrd)
  PredWrd <- rbind(PredN4Wrd, PredN3Wrd)
  PredWrd <- rbind(PredWrd, PredN2Wrd)

  PredWrd <- arrange(PredWrd, desc(WtFreq))
  Wrd <- PredWrd$Wrd
  Wrd1 <- as.data.frame(as.character(FtN1$PRED))
  colnames(Wrd1) <- c("Wrd")
  Wrd <- as.data.frame(as.character(Wrd))
  colnames(Wrd) <- c("Wrd")
  Wrd <- rbind(Wrd, Wrd1)
  Wrd <- distinct(Wrd)
  Predictions <- Wrd[1:6,]
  Predictions <- as.data.frame(Predictions)
  Predictions
  })
  
  #output$txt2 <- renderPrint(input$txt1)
  })
