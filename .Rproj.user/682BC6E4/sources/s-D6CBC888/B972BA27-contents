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
      @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
      body {
        background-color: white;
        color: black;
        font-family : 'Bitter';
      }
      #infos{
      background-color : #FFE4C4;
      }
      #notes{
      width : 400px;
      height : 200px;
      }
      ")
        )
    ),
    # Application title
    titlePanel("History of cinema"),
    #Page de navigation
    navbarPage("My Application",
               # Page 1
               tabPanel("History of cinema"
                        ),
               # Page 2
               tabPanel("Moteur de recherche",
                    splitLayout(
                        verticalLayout(
                        # Barre de recherhe
                        textInput(inputId = "mname", label = "Chercher un film :", value = "Fargo"),
                        #Nom du réalisateur
                        box(id = "infos",title = "Informations",
                            solidHeader = TRUE,
                            h4("Réalisateur(s) :"),
                            textOutput("real"),
                            h4("Récompenses :"),
                            textOutput("osc")),
                            h4("Notes :"),
                        # Notes ImDb et Metascore
                        box(id = "notes",splitLayout(
                        amChartsOutput(outputId = "ImDb_note"),
                        amChartsOutput(outputId = "Metascore")
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
                ),
               tabPanel("Component 3")
    ),
    
)
)
