library(shiny)
library(shinyWidgets)
library(ngram)
library(stringr)

dfg2=read.table("data/dfg2.txt")
dfg=read.table("data/dfg.txt")

predictword=function(phrase,num){
  phrase=tolower(phrase)
  phrase=concatenate(str_squish(phrase),"")
  splitphrase=unlist(strsplit(phrase," "))
  len=length(splitphrase)
  
  if(len>=3){
    point=len-1
    phrase1=concatenate(splitphrase[point:len])
    phrase=concatenate("^",phrase1,collapse = "")
    words=dfg[grep(phrase,dfg[,1]),1]
    words1=words[num]
    words2=unlist(strsplit(words1," "))
    if(is.na(words2[3])){
      len=1
      phrase=splitphrase[len]
    }else{
      word=words2[3] 
      word=concatenate(word)
      return(word)
      paste(word)}
  }
  
  if(len==2){
    phrase=concatenate("^",phrase,collapse = "")
    words=dfg[grep(phrase,dfg[,1]),1]
    words1=words[num]
    words2=unlist(strsplit(words1," "))
    if(is.na(words2[3])){
      len=1
      phrase=splitphrase[2]
    }else{
      word=words2[3] 
      word=concatenate(word)
      return(word)
      paste(word)}
  }
  
  if(len==1 && phrase!=" "){
    phrase=concatenate("^",phrase,collapse = "")
    words=dfg2[grep(phrase,dfg2[,1]),1]
    words1=words[num]
    words2=unlist(strsplit(words1," "))
    if(is.na(words2[2])){
      print(" ")
    }else{
      word=words2[2]
      word=concatenate(word)
      return(word)
      paste(word)}
  }
  
}


shinyServer(function(input, output) {
  
  output$guide=renderText(paste("In this application you can enter any word or phrase in the text box area and get your text with the next predicted word. You can also choose the number of words that you want to be predicted. But it won't predict anything if the words are not English."))
  
    output$sent1= renderText({
      word1=predictword(input$text,1)
      paste("<h3>","First predicted text","</h3>",input$text,word1)
    })
    
    output$sent2=reactive({
      if(input$check=="Two"){
        word2=predictword(input$text,2)
        paste("<h3>","Second predicted text","</h3>",input$text,word2)
      }
    })

})
