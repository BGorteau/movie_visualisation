#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(igraph)
library(visNetwork)
library(flexdashboard)
library(rAmCharts)
library(plotly)
library(tidyverse)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # Importation des données OMDB
    OMDB <- as_tibble(read.csv("data/omdb.csv", sep=",", header = TRUE, row.names = 1))
    
    # Fonction comparaison valeurs qualitatives
    comparaison_quali <- function(string, string_comp){
        score <- 0
        for(i in str_split(string, ", ")){
            for(j in i){
                if(grepl(j,string_comp)==TRUE){
                    score <- score + 1
                }
            }
        }
        return(score)
    }  
    
    # Fonction comparaison valeurs quantitatives
    comparaison_quanti <- function(val1, val2, max){
        if(is.na(val1)!=TRUE && is.na(val2)!=TRUE){
            return(1-(abs(as.numeric(val1)-as.numeric(val2))/max))
        } else {
            return(0)
        }
    }
    
    #Fonction conseils des films
    similar_movies <- function(film){
      if(film %in% OMDB$Title){
        # On sélectionne le film dans la base de donnée 
        movie <- filter(OMDB, Title== film)
        
        # On créé la base de donnée sans le film qu'on choisit
        df_comp <- filter(OMDB, !Title == film)
        
        # On créé le vecteur des scores de comparaison
        vect_score <- rep(0,nrow(df_comp))
        
        #------------------------------------------------------------------
        
        # --- Variables qualitatives --- #
        
        # Genres :
        for(i in seq(nrow(df_comp))){
            vect_score[i] <- vect_score[i]+comparaison_quali(movie[7],df_comp[i,7])
        }
        
        # Réalisateur :
        for(i in seq(nrow(df_comp))){
            vect_score[i] <- vect_score[i]+comparaison_quali(movie[9],df_comp[i,9])
        }
        
        # Acteurs :
        for(i in seq(nrow(df_comp))){
            vect_score[i] <- vect_score[i]+comparaison_quali(movie[11],df_comp[i,11])
        }
        
        # Langue :
        for(i in seq(nrow(df_comp))){
            vect_score[i] <- vect_score[i]+comparaison_quali(movie[15],df_comp[i,15])
        }
        
        # Pays :
        for(i in seq(nrow(df_comp))){
            vect_score[i] <- vect_score[i]+comparaison_quali(movie[16],df_comp[i,16])
        }
        # --- Variables quantitatives --- #
        # Metascore
        for(i in seq(nrow(df_comp))){
            vect_score[i] <- vect_score[i]+comparaison_quanti(movie[12],df_comp[i,12],100)
        }
        
        # ImDb rating
        for(i in seq(nrow(df_comp))){
            vect_score[i] <- vect_score[i]+comparaison_quanti(movie[13],df_comp[i,13],10)
        }
        
        #------------------------------------------------------------------
        
        # Jointure du vecteur des score avec la base de donnée sans le film
        df_comp <- df_comp %>%
            add_column(vect_score)
        
        # Tri de la base en fonction du score
        df_comp <- arrange(df_comp, -vect_score)
        df_comp <- select(df_comp, Title)
        return(head(df_comp))
      } else {
        return("Nom de film invalide !")
      }
    }
    
    # Sortie du tableau 
    output$table_film <- renderDataTable(
      similar_movies(input$mname), 
      options = list(searching = FALSE,
                     paging = FALSE,
                     paginate = FALSE,
                     info = FALSE
                     )
    )
    
    # Fonctions compteur notes
    #ImDb
    ImDb_score <- function(movie_name){
      movie <- filter(OMDB, Title == movie_name)
      bands = data.frame(start = c(0), end = c(10), 
                         color = c("#ffac29"),
                         stringsAsFactors = FALSE)
      return(amAngularGauge(x = movie$imdbRating,start = 0, end=10, step = 1,bands = bands, main = "ImDb Note"))
    }
    #Metascore
    metascore_score <- function(movie_name){
      movie <- filter(OMDB, Title == movie_name)
      bands = data.frame(start = c(0, 40, 60), end = c(40, 60, 100), 
                         color = c("#00CC00", "#ffac29", "#ea3838"),
                         stringsAsFactors = FALSE)
      return(amAngularGauge(x = movie$Metacritic, bands = bands, main = "Metascore"))
    }
    # Sortie du compteur ImDb
    output$ImDb_note <- renderAmCharts(ImDb_score(input$mname))
    # Sortie compteur Metascore
    output$Metascore <- renderAmCharts(metascore_score(input$mname))
    
    # Fonction affichage acteurs
    actors <- function(film){
      list_actors <- c()
      movie <- filter(OMDB, Title== film)
      for(i in str_split(movie[11], ", ")){
        list_actors <- c(list_actors,i)
      }
      tableau <- as_tibble(table(list_actors))
      tableau <- select(tableau, list_actors)
      return(tableau)
    }
    
    # Sortie tableau acteurs film
    output$acteurs <- renderDataTable(
      actors(input$mname),
      options = list(searching = FALSE,
                     paging = FALSE,
                     paginate = FALSE,
                     info = FALSE
      )
    )
    # Réalisateur
    
    #Fonction retournant les réalisateurs d'un film
    realisators <- function(film){
      real <- c()
      movie <- filter(OMDB, Title== film)
      for(i in movie[9]){
        real <- c(real,i)
      }
      return(real[1])
    }
    # Affichage
    output$real <- renderText({ 
      realisators(input$mname)
    })
    
    # Récompenses :
    # Fonction :
    oscars <- function(film){
      rec <- c()
      movie <- filter(OMDB, Title== film)
      for(i in movie[19]){
        rec <- c(rec,i)
      }
      return(paste("Oscars :",rec[1]))
    }
    # Affichage :
    output$osc <- renderText({ 
      oscars(input$mname)
    })
    
})
