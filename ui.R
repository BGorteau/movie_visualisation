#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny.router)
library(rAmCharts)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Style de la page (CSS)
    tags$head(
        tags$style(
            HTML("
      @import url('https://fonts.googleapis.com/css2?family=Roboto+Slab&display=swap');
      body {
        background-color: #DCDCDC;
        color: black;
        font-family : 'Roboto Slab';
      }
      #infos{
      background-color : rgb(245,197,24);
      width : 370px;
      border: 3px solid black;
      border-radius : 15px;
      padding: 5px;
      }
      #notes{
      width : 370px;
      height : 200px;
      background-color : rgb(245,197,24);
      border: 3px solid black;
      }
      ")
        )
    ),
    #Page de navigation
    navbarPage("History of Cinema",
               # Page 1
               tabPanel("History of cinema"
                        ),
               # Page 2
               tabPanel("Moteur de recherche",
                    verticalLayout(
                      # Barre de recherhe
                      textInput(inputId = "mname", label = "Chercher un film :", value = "Fargo"),
                      splitLayout(
                        verticalLayout(
                        #Nom du réalisateur
                        box(id = "infos",title = "Informations",
                            h4("Réalisateur(s) :"),
                            textOutput("real"),
                            h4("Récompenses :"),
                            textOutput("osc")),
                            h4("Notes :"),
                        # Notes ImDb et Metascore
                        box(id = "notes",splitLayout(
                        amChartsOutput(outputId = "ImDb_note",  height = "180px", width = "160px"),
                        amChartsOutput(outputId = "Metascore", height = "180px", width = "160px")
                        ))
                        ),
                        # Affichage tu tableau dees films conseillés
                        verticalLayout(
                            h4("Acteurs :"),
                            dataTableOutput(outputId = "acteurs"),
                            h4("Films similaires :"),
                            dataTableOutput(outputId = "table_film")
                        )
                    ) 
                    )
                ),
               tabPanel("Component 3")
    ),
    
)
)
