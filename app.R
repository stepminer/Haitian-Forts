#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

 
 library(shiny)
library(leaflet)
library(DT)

# Load the dataset
forts_data <- data.frame(
  Nom = c("Citadelle Laferrière", "Fort des Anglais (Saint-Louis du Sud)", "Fort Dauphin / Fort Liberté",
          "Fort Dimanche", "Fort Jalousie (Marmelade)", "Fort Labrouque (Fort-Liberté)", 
          "Fort LaCharte (Fort Liberté)", "Fort La Crête-à-Pierrot", "Fort Goman (Jérémie)",
          "Fort Jacques et Alexandre (Pétion-ville)", "Fort Littoral", "Fort National", 
          "Fort des Oliviers", "Fort La Petite Anse", "Fort Picolet", "Fort Platon (Cayes)", 
          "Fort Saint-Charles (Port-de-Paix)", "Fort Saint-Joseph (Fort Liberté)", 
          "Fort Saint-Michel", "Fort des Trois Pavillons (Port-de-Paix)", "Fort Vallières (Port-de-Paix)", 
          "Palais Sans-Souci", "Palais 365 Portes"),
  Latitude = c(19.5731, 18.2667, 19.6627, 18.5581, 19.5167, 19.7069, 19.6678, 
               19.0000, 18.6333, 18.5000, 19.9333, 18.5500, 19.7500, 19.7500, 
               19.7827, 18.2000, 19.9333, 19.6678, 19.7500, 19.9333, 19.9333, 
               19.6042, 19.9333),
  Longitude = c(-72.2433, -73.9667, -71.8379, -72.3333, -72.3333, -71.8443, 
                -71.8397, -72.4167, -74.1167, -72.2833, -72.8333, -72.3333, 
                -72.2000, -72.2000, -72.1891, -73.7500, -72.8333, -71.8397, 
                -72.2000, -72.8333, -72.8333, -72.2183, -72.8333),
  Garnison = c(5000, 2000, 1200, 500, 800, 1000, 800, 2500, 1000, 1500, 1200, 
               2000, 1000, 800, 1200, 1000, 800, 700, 1000, 1200, 1500, 500, 800),
  Cannons = c(365, 50, 30, 10, 15, 25, 20, 45, 20, 30, 25, 40, 20, 15, 20, 30, 
              10, 15, 20, 20, 35, 5, 10),
  Superficie = c(10000, 5000, 3000, 1200, 2500, 3500, 2800, 6500, 3000, 4000, 
                 3500, 4500, 3000, 2500, 3000, 4000, 2500, 2000, 3000, 3000, 
                 4500, 2000, 3000),
  Link = c("https://lh3.googleusercontent.com/p/AF1QipO5KtBqiusY8AsKERqRwExhO76cQCGJ8uKb8nMj=s1360-w1360-h1020", "https://images.squarespace-cdn.com/content/v1/53348503e4b09be6564e601a/1405712105433-7ZVHP4EVH1JU6127LOTO/image-asset.jpeg?format=1500w",
           "https://lh3.googleusercontent.com/p/AF1QipMDydw6nsjJQAYqDdTy9rv4r_ZEKu_CuMorUu3z=s1360-w1360-h1020", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzRilYZMHYoyd372AV95LxfgpVUUvpq-Duww&s", 
           "https://www.rivalhotelhaiti.com/files/2015/01/Fort-Magny.jpg", "https://lh3.googleusercontent.com/p/AF1QipOJle8JQzEMyofQ7z4xvsF_o_zcv-HkKO9g-PUt=s1360-w1360-h1020", 
           "https://scontent-yyz1-1.xx.fbcdn.net/v/t39.30808-6/261960644_3721200001439453_3766649586223216822_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_ohc=VyxcsoEtbK8Q7kNvgFOqfDa&_nc_zt=23&_nc_ht=scontent-yyz1-1.xx&_nc_gid=AoShnlqI6snrdAY5ftScjkM&oh=00_AYAJfdi73YRjummXgmpkdxvlQ9vxq6geEDc-lpUWYXh_SQ&oe=676E2FBF", "https://images.squarespace-cdn.com/content/v1/53348503e4b09be6564e601a/1397503480364-KBPIGT5RGY7Z6AIWTUC8/image1.JPG?format=2500w", 
           "https://cliophoto.clionautes.org/upload/2017/03/22/20170322170258-7995f94b.jpg", "https://lh3.googleusercontent.com/p/AF1QipMq3a0a70hoiVRpVjIde_TS9YPPJlSYyLdfR8LW=s1360-w1360-h1020", 
           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjZ8asLtL5Q3Itk8NKvvHLtjn1WlUwvGZFXg&s", "https://lh3.googleusercontent.com/p/AF1QipO5vyii3o0HpLiCTXPyaXk1PdG12w0V0z09e2Yx=s1360-w1360-h1020", 
           "http://www.starforts.com/gr/oge/ogewishitwerethewholething.jpg", "https://scontent-yyz1-1.xx.fbcdn.net/v/t39.30808-6/459905610_839306948382221_5999085597332913584_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_ohc=wWidHAq77JMQ7kNvgGSm0xL&_nc_zt=23&_nc_ht=scontent-yyz1-1.xx&_nc_gid=AwPg7dLL0mYo0gLYogC3_nT&oh=00_AYCkjQFsKoI0H98JMsJQBSgTTkbtoZQHSHq_VnPizp6pGw&oe=676E0E39", 
           "https://www.rivalhotelhaiti.com/files/2015/01/fort-picolet.jpg", "https://images.squarespace-cdn.com/content/v1/53348503e4b09be6564e601a/1398261792976-QQTE9TU3H2ABZIC1XAHQ/image0.jpg?format=2500w", 
           "https://www.rivalhotelhaiti.com/files/2015/01/640px-Fort_Saint_Joseph_-_Fort_Liberte_Looking_South.jpg", 
           "https://haitiwonderland.com/assets/images/upload/blog/haiti_haiti--fort-saint-joseph--vestige-historique-de-la-resistance_1712199307.png", "https://lh3.googleusercontent.com/p/AF1QipOJvlL_qR8HOVDU46-sAkirWKak-gzbM5brL5Vw=s1360-w1360-h1020l", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFIXRbX5VNrfoMevDADK1jDt0VioezwqASA-kliGXS6S6QkoEMBO-Qfmp14_p-BwdI-VI&usqp=CAU", 
           "https://scontent-yyz1-1.xx.fbcdn.net/v/t39.30808-6/465845680_28393559026910007_4693097821016119751_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_ohc=MI7SWeEEhQwQ7kNvgGOMQkC&_nc_zt=23&_nc_ht=scontent-yyz1-1.xx&_nc_gid=AktPknF3CPC9S9BbvtXH9U2&oh=00_AYCj5bLwqizLttYUI5vVfdrVAGm7qwPi3JXAG2j5vmI6jg&oe=676E0050", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Palais_du_sans-soucis.JPG/1024px-Palais_du_sans-soucis.JPG", 
           "https://images.squarespace-cdn.com/content/v1/53348503e4b09be6564e601a/1397747949740-W8K3HIQKTLDVB2SEA38Z/image11.jpg?format=2500w")
)

# Define UI
ui <- fluidPage(
  titlePanel("Haitian Forts"),
  sidebarLayout(
    sidebarPanel(
      h4("Explore Haitian Forts"),
      p("Click markers on the map for more details."),
      p("Data table below displays additional details."),
      hr(),
      p("Links provided for more info or images.")
    ),
    mainPanel(
      leafletOutput("forts_map", height = 600),
      DTOutput("forts_table")
    )
  )
)

# Define server
server <- function(input, output, session) {
  
  # Render Leaflet Map
  output$forts_map <- renderLeaflet({
    leaflet(data = forts_data) %>%
      addTiles() %>%
      addMarkers(
        ~Longitude, ~Latitude,
        popup = ~paste0(
          "<strong>", Nom, "</strong><br>",
          "Garnison: ", Garnison, "<br>",
          "Cannons: ", Cannons, "<br>",
          "Superficie: ", Superficie, " m²<br>",
          "<a href='", Link, "' target='_blank'>More Info</a>"
        )
      )
  })
  
  # Render Data Table
  output$forts_table <- renderDT({
    datatable(forts_data, options = list(pageLength = 10), escape = FALSE)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

