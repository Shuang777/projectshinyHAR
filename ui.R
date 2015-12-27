library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Human Activity Recognition Using Random Forest"),
    sidebarPanel(
      h3("Inputs for training random forest"),
      numericInput('numnodes', 'Num nodes in random forest', 5, min = 1, max = 20, step = 1),
      numericInput('numfolds', 'Num folds for cross-validation', 5, min = 1, max = 8, step = 1),
      submitButton('Submit'),
      h4("This may take 1 minutes to compute.")
    ),
    mainPanel(
      h3("Results of prediction"),
      h4("Number of nodes in random forest"),
      verbatimTextOutput("numnodes"),
      h4("Number of folds in K-fold cross-validation"),
      verbatimTextOutput("numfolds"),
      h4("Average prediction accuracy"),
      verbatimTextOutput("accuracy")
    )
  )
)