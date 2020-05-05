source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly")
libraryRequireInstall("tidyverse")
####################################################

################### Actual code ####################

fix_colnames <- function(df){
  colnames(df) <- str_replace_all(colnames(df), "[^A-Za-z0-9]", "_")
  colnames(df) <- paste0("a", colnames(df))
  return(df)
}

#PBI_PARAM fitting of scatterplot points
#Type:bool, Default:TRUE, Range:NA, PossibleValues:NA, Remarks: NA
fitting = TRUE
if(exists("settings_fitting_params_fitting")){
  fitting = settings_fitting_params_fitting
}

fitting_se = TRUE
if(exists("settings_fitting_params_se")){
  fitting_se = settings_fitting_params_se
}

fitting_level = 0.95
if(exists("settings_fitting_params_level")){
  fitting_level = as.numeric(settings_fitting_params_level)
}

scatter_size = 1
if(exists("settings_scatter_params_size")){
  scatter_size = as.numeric(settings_scatter_params_size)
}

scatter_alpha = 1
if(exists("settings_scatter_params_opacity")){
  scatter_alpha = as.numeric(settings_scatter_params_opacity)/100
}


x_label <- colnames(x)[[1]]
y_label <- colnames(y)[[1]]

color_label <- NULL
facet_row_label <- NULL
facet_col_label <- NULL

x <- fix_colnames(x)
y <- fix_colnames(y)

x_colname <- colnames(x)[[1]]
y_colname <- colnames(y)[[1]]
color_colname <- NULL
facet_row_colname <- "."
facet_col_colname <- "."

dataset <- cbind(x, y)

if(exists("color")) {
  color_label <- colnames(color)[[1]]
  color <- fix_colnames(color)

  dataset <- cbind(dataset, color)
  color_colname <- colnames(color)[[1]]
} else {
  scatter_color = "orange"
  if(exists("settings_scatter_params_color")) {
    scatter_color = settings_scatter_params_color
  }   
}

if(exists("facet_row")) {
  facet_row_label <- colnames(facet_row)[[1]]
  facet_row <- fix_colnames(facet_row)

  dataset <- cbind(dataset, facet_row)
  facet_row_colname <- colnames(facet_row)[[1]]

  fix_facet_row_label <- function(label) {
    paste0(facet_row_label, ": ", label)
  }
  #fix_facet_row_label <- as_labeller(fix_facet_row_label)
} else {
  fix_facet_row_label <- NULL
}

if(exists("facet_col")) {
  facet_col_label <- colnames(facet_col)[[1]]
  facet_col <- fix_colnames(facet_col)

  dataset <- cbind(dataset, facet_col)
  facet_col_colname <- colnames(facet_col)[[1]]

  fix_facet_col_label <- function(label) {
    paste0(facet_col_label, ": ", label)
  }
  #fix_facet_col_label <- as_labeller(fix_facet_col_label)
} else {
  fix_facet_col_label <- NULL
}

p <- ggplot(data = dataset, 
            mapping = aes_string(
                x_colname, 
                y_colname, 
                color = color_colname)) 

if(exists("color")) {
  p <- p + geom_point(size = scatter_size, 
                      alpha = scatter_alpha)
} else {
  p <- p + geom_point(size = scatter_size, 
                      alpha = scatter_alpha,
                      color = scatter_color)
}

if (fitting) {
  p <- p + geom_smooth(method = "lm", se = fitting_se, level = fitting_level)
}

if (exists("facet_row") | exists("facet_col")) {
  p <- p + facet_grid(reformulate(facet_col_colname, facet_row_colname), # the formula generated is "facet_row_colname ~ facet_col_colname"
                      labeller = labeller(#.rows = as_labeller(fix_facet_row_label,
                                           #                   default = label_value),
                                          .cols = as_labeller(fix_facet_col_label,
                                                              default = label_value)))
}

p <- p + labs(x = x_label,
              y = y_label,
              color = color_label
              )

####################################################

############# Create and save widget ###############
p <- ggplotly(p);
internalSaveWidget(p, 'out.html');
####################################################
