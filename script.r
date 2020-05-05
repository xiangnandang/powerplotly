########## Known Limitation of ggplotly ############
# Ignore theme(legend.position)
# Ignore geom_text(vjust, hjust)
# Ignore facet_grid(space)
# Does not support well title, subtitle, caption
# need more margins for showing x y labels correctly
####################################################


source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly")
#libraryRequireInstall("ggpmisc")
#libraryRequireInstall("tidyverse")
####################################################

source('./r_files/ggplot_smooth_func.r')

################### Actual code ####################

#PBI_PARAM fitting of scatterplot points
#Type:bool, Default:TRUE, Range:NA, PossibleValues:NA, Remarks: NA

saving = FALSE
if(exists("settings_saving_params_show")){
  saving = settings_saving_params_show
}

# saving_filename = "figure.html"
# if(exists("settings_saving_params_filename")){
#   saving_filename = settings_saving_params_filename
# }

fitting = TRUE
if(exists("settings_fitting_params_show")){
  fitting = settings_fitting_params_show
}

fitting_equation = TRUE
if(exists("settings_fitting_params_equation")){
  fitting_equation = settings_fitting_params_equation
}

fitting_equationsize = 3
if(exists("settings_fitting_params_equationsize")){
  fitting_equationsize = settings_fitting_params_equationsize
}

fitting_equationx = 0.75
if(exists("settings_fitting_params_equationx")){
  fitting_equationx = min(max(settings_fitting_params_equationx, 0), 1)
}

fitting_equationy = 1
if(exists("settings_fitting_params_equationy")){
  fitting_equationy = min(max(settings_fitting_params_equationy, 0), 1)
}

fitting_lineWidth = 1
if(exists("settings_fitting_params_lineWidth")){
  fitting_lineWidth = settings_fitting_params_lineWidth
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

xaxis_factor = FALSE
if (exists("settings_xaxis_params_factor")) {
  xaxis_factor = settings_xaxis_params_factor
}

xaxis_xstart = NA_real_
if (exists("settings_xaxis_params_xstart")) {
  xaxis_xstart = settings_xaxis_params_xstart
}

xaxis_xend = NA_real_
if (exists("settings_xaxis_params_xend")) {
  xaxis_xend = settings_xaxis_params_xend
}

xaxis_xtitle = ""
if (exists("settings_xaxis_params_xtitle")) {
  xaxis_xtitle = settings_xaxis_params_xtitle
}

xaxis_xtitlesize = NULL
if (exists("settings_xaxis_params_xtitlesize")) {
  xaxis_xtitlesize = settings_xaxis_params_xtitlesize
}

xaxis_xtextsize = NULL
if (exists("settings_xaxis_params_xtextsize")) {
  xaxis_xtextsize = settings_xaxis_params_xtextsize
}

yaxis_factor = FALSE
if (exists("settings_yaxis_params_factor")) {
  yaxis_factor = settings_yaxis_params_factor
}

yaxis_ystart = NA_real_
if (exists("settings_yaxis_params_ystart")) {
  yaxis_ystart = settings_yaxis_params_ystart
}

yaxis_yend = NA_real_
if (exists("settings_yaxis_params_yend")) {
  yaxis_yend = settings_yaxis_params_yend
}

yaxis_ytitle = ""
if (exists("settings_yaxis_params_ytitle")) {
  yaxis_ytitle = settings_yaxis_params_ytitle
}

yaxis_ytitlesize = NULL
if (exists("settings_yaxis_params_ytitlesize")) {
  yaxis_ytitlesize = settings_yaxis_params_ytitlesize
}

yaxis_ytextsize = NULL
if (exists("settings_yaxis_params_ytextsize")) {
  yaxis_ytextsize = settings_yaxis_params_ytextsize
}

legend_factor = TRUE
if (exists("settings_legend_params_factor")) {
  legend_factor = settings_legend_params_factor
}

legend_colortitle = ""
if (exists("settings_legend_params_colortitle")) {
  legend_colortitle = settings_legend_params_colortitle
}

legend_colortitlesize = NULL
if (exists("settings_legend_params_colortitlesize")) {
  legend_colortitlesize = settings_legend_params_colortitlesize
}

legend_colortextsize = NULL
if (exists("settings_legend_params_colortextsize")) {
  legend_colortextsize = settings_legend_params_colortextsize
}

# legend_orientation = "h"
# if (exists("settings_legend_params_orientation")) {
#   legend_orientation = settings_legend_params_orientation
# }

facetgrid_scales = "fixed"
if (exists("settings_facetgrid_params_scales")) {
  facetgrid_scales = settings_facetgrid_params_scales
}

facetgrid_space = "fixed"
if (exists("settings_facetgrid_params_space")) {
  facetgrid_space = settings_facetgrid_params_space
}

facetgrid_labeller = "label_both"
if (exists("settings_facetgrid_params_labeller")) {
  facetgrid_labeller = settings_facetgrid_params_labeller
}

facetgrid_horizontaltextsize = NULL
if (exists("settings_facetgrid_params_horizontaltextsize")) {
  facetgrid_horizontaltextsize = settings_facetgrid_params_horizontaltextsize
}

facetgrid_verticaltextsize = NULL
if (exists("settings_facetgrid_params_verticaltextsize")) {
  facetgrid_verticaltextsize = settings_facetgrid_params_verticaltextsize
}

title_title = ""
if (exists("settings_title_params_title")) {
  title_title = settings_title_params_title
}

title_fontsize = NULL
if (exists("settings_title_params_fontsize")) {
  title_fontsize = settings_title_params_fontsize
}

theme_theme = "gray"
if (exists("settings_theme_params_theme")) {
  theme_theme = settings_theme_params_theme
}



if (xaxis_factor) {
  x[[1]] <- factor(x[[1]])
}

if (yaxis_factor) {
  y[[1]] <- factor(y[[1]])
}

x_colname <- colnames(x)[[1]]
y_colname <- colnames(y)[[1]]
x_colname <- paste0("`", x_colname, "`")
y_colname <- paste0("`", y_colname, "`")

color_colname <- NULL
facet_row_colname <- "."
facet_col_colname <- "."

dataset <- cbind(x, y)

if (exists("yerror")) {
  ymin <- data.frame(ymin = y[[1]] - yerror[[1]])
  ymax <- data.frame(ymax = y[[1]] + yerror[[1]]) 
  dataset <- cbind(dataset, ymin, ymax)
}

if(exists("color"))
  { if (legend_factor) {
      color[[1]] <- factor(color[[1]])
    }
    dataset <- cbind(dataset, color)
    color_colname <- colnames(color)[[1]]
    color_colname <- paste0("`", color_colname, "`")
  } else {
    scatter_color = "blue"
    if(exists("settings_scatter_params_color")){
      scatter_color = settings_scatter_params_color
    }   
  }

if(exists("facet_row"))
  {
    dataset <- cbind(dataset, facet_row)
    facet_row_colname <- colnames(facet_row)#[[1]]
    #facet_row_colname <- paste(facet_row_colname, sep = "+")
    facet_row_colname <- paste(paste0("`", facet_row_colname, "`"), collapse = "+")
  }

if(exists("facet_col"))
  {
    dataset <- cbind(dataset, facet_col)
    facet_col_colname <- colnames(facet_col)#[[1]]
    facet_col_colname <- paste(paste0("`", facet_col_colname, "`"), collapse = "+")
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

if (exists("yerror")) {
  p <- p + geom_errorbar(aes(ymin = ymin, ymax = ymax))
}

if (fitting) {
  formula <- y ~ x
  p <- p + geom_smooth(method = "lm", 
                        size = fitting_lineWidth, 
                        se = fitting_se, 
                        level = fitting_level) 

  if (fitting_equation) {
    p <- p +
      #stat_poly_eq(aes(label = ..eq.label..), formula = formula, parse = FALSE)
      stat_smooth_func(geom="text", method="lm", formula = y ~ x, parse=TRUE, 
                        size = fitting_equationsize,
                        xpos = fitting_equationx, 
                        ypos = fitting_equationy)
  }

}

if (exists("facet_row") | exists("facet_col")) {
  p <- p + facet_grid(#reformulate(facet_col_colname, facet_row_colname),
                      as.formula(paste(facet_row_colname, "~", facet_col_colname)),
                      scales = facetgrid_scales,
                      space = facetgrid_space,
                      labeller = facetgrid_labeller) # the formula generated is "facet_row_colname ~ facet_col_colname"
}

if (!xaxis_factor) {
  p <- p + 
    xlim(xaxis_xstart, xaxis_xend)
}

if (!yaxis_factor) {
  p <- p + 
    ylim(yaxis_ystart, yaxis_yend)
}

if (xaxis_xtitle != "") {
  p <- p + xlab(xaxis_xtitle)
}

if (yaxis_ytitle != "") {
  p <- p + ylab(yaxis_ytitle)
}

if (legend_colortitle != "") {
  p <- p + labs(color = legend_colortitle)
}

if (theme_theme == "gray") {
  p <- p + theme_gray()
}

if (theme_theme == "bw") {
  p <- p + theme_bw()
}

if (theme_theme == "linedraw") {
  p <- p + theme_linedraw()
}

if (theme_theme == "light") {
  p <- p + theme_light()
}

if (theme_theme == "dark") {
  p <- p + theme_dark()
}

if (theme_theme == "minimal") {
  p <- p + theme_minimal()
}

if (theme_theme == "classic") {
  p <- p + theme_classic()
}

if (theme_theme == "void") {
  p <- p + theme_void()
}


p <- p + 
  theme(axis.title.x = element_text(size = xaxis_xtitlesize),
        axis.text.x = element_text(size = xaxis_xtextsize),
        axis.title.y = element_text(size = yaxis_ytitlesize),
        axis.text.y = element_text(size = yaxis_ytextsize),
        legend.title = element_text(size = legend_colortitlesize),
        legend.text = element_text(size = legend_colortextsize),
        strip.text.x = element_text(size = facetgrid_horizontaltextsize),
        strip.text.y = element_text(size = facetgrid_verticaltextsize))


#p <- p + theme(legend.position = legend_position)

####################################################

############# Create and save widget ###############
p <- ggplotly(p) %>%
  layout(margin = list(l = 100, t = 50))

if (title_title != "") {
  p <- p %>%
    layout(title = list(text = title_title, y = 1))
}

p <- p %>%
  layout(title = list(font = list(size = title_fontsize)))

#p <- p %>% toWebGL()
if (!saving) {
  internalSaveWidget(p, 'out.html')
} else {
  htmlwidgets::saveWidget(p, "out.html", selfcontained = TRUE)
  filename <- file.choose()
  filename <- paste0(gsub(".html", "", filename, ignore.case=T), "_pBIplotly.html")
  file.copy("out.html", filename, overwrite = TRUE, recursive = FALSE,
          copy.mode = TRUE, copy.date = FALSE)
}


####################################################
