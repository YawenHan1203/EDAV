


shinyServer(function(input, output) {
  #The background Map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(
        urlTemplate = "https://api.mapbox.com/v4/mapbox.streets/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZnJhcG9sZW9uIiwiYSI6ImNpa3Q0cXB5bTAwMXh2Zm0zczY1YTNkd2IifQ.rjnjTyXhXymaeYG6r2pclQ",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>%
      setView(lng = -73.97, lat = 40.70, zoom = 11)
  })
  
  
  ###Filter the data
  
  TType <- reactive({
    t <- Trees
    
    if(length(input$Tree)!=0){
      t = t[t$Tree_species==input$Tree,]
#      t = t[t$category=="Oak",]
#      dim(t)
#      t = filter(t,t$category == input$Tree)
    }
    if(input$Status==T){
      t = t[t$status== "Alive",]
#      t = filter(t,t$status=="Alive")
    }
    return(t)
  })
  
  #Add circless to the Trees
  observe({
    leafletProxy("map") %>%
      clearShapes() %>%
        addCircles(data = TType(), ~longitude, ~latitude,radius=0.5,opacity=0.2,color="green")
  })
  
  
  
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste( input$variable,"~ borough")
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
 
  
  # Generate a plot of the requested variable against mpg ----
  # and only exclude outliers if requested
  output$mpgPlot <- renderPlot({
    orderlevel1 = c("Queens","Brooklyn","Staten Island","Bronx","Manhattan")
    if (input$variable=="Tree_species"){
      fillcolors <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7","white","#000000")
      orderlevel2 = c("London planetree", "honeylocust","Callery pear","pin oak","Norway maple","littleleaf linden",
                      "cherry","Japanese zelkova","ginkgo","Sophora")
    }else{
      fillcolors <- c("#999999", "#E69F00", "#56B4E9")
      orderlevel2 = c("TreesCount Staff", "Volunteer","NYC Parks Staff")
    }
    Trees$borough=factor(Trees$borough,levels=orderlevel1)
    Trees$Recorder_type=factor(Trees$Recorder_type,levels=orderlevel2)
    Trees$Tree_species=factor(Trees$Tree_species,levels=orderlevel2)
    
    
    vcd::mosaic(as.formula(formulaText()), Trees,
                direction = c("v", "h"),
                rot_labels=c(0,0,0,70), gp = gpar(fill = fillcolors),
                rot_varnames = c(0,0,0,90), offset_varnames = c(0.7,0,0,0.6), 
                offset_labels=c(0.5,0,0,0.2)
              
                
    )},height = 800,width = 800)
  

  
  })
