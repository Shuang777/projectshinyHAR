
predictHAR <- function(n,k) {
  accuracy <- function(model,testset){sum(predict(fit, testset) == testset$classe)/nrow(testset)}
  
  library(randomForest)
  traindata <- read.csv("training.csv")
  set.seed(7)
  order <- sample(nrow(traindata), size = nrow(traindata), replace = FALSE)
  
  nrowspercv <- nrow(traindata) / k
  acc = c();
  for (i in 1:k){
    part <- order[((i-1)*nrowspercv+1):min(i*nrowspercv, nrow(traindata))]
    
    fit <- randomForest(classe ~ roll_belt + pitch_belt + yaw_belt + total_accel_belt + roll_arm + pitch_arm + yaw_arm + total_accel_arm + roll_dumbbell + pitch_dumbbell + yaw_dumbbell + total_accel_dumbbell + roll_forearm + pitch_forearm + yaw_forearm + total_accel_forearm, method = "rf", data = traindata[-part,], nodesize=n, allowParallel=TRUE)
    acc <- c(acc, accuracy(fit, traindata[part,]))
  }
  mean(acc)
}

shinyServer(
  function(input, output){
    output$numnodes <- renderPrint({input$numnodes})
    output$numfolds <- renderPrint({input$numfolds})
    output$accuracy <- renderPrint({predictHAR(input$numnodes, input$numfolds)})
  }
)