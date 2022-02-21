## 1. Which of the following is a principle of analytic graphics?
## no  - Only do what your tools allow you to do
## no  - Show box plots (univariate summaries)
## yes - Show comparisons
## no  - Don't plot more than two variables at at time
## no  - Make judicious use of color in your scatterplots

## 2. What is the role of exploratory graphs in data analysis?
## yes - They are typically made very quickly.
## - Only a few are constructed.
## - Axes, legends, and other details are clean and exactly detailed.
## - They are made for formal presentations.

## 3. Which of the following is true about the base plotting system?
## no  - Margins and spacings are adjusted automatically depending on
##       the type of plot and the data
## no  - Plots are typically created with a single function call
## yes - Plots are created and annotated with separate functions
## - The system is most useful for conditioning plots

## 4. Which of the following is an example of a valid graphics device in R?
## yes - A PDF file
## - A socket connection
## - The keyboard
## - A file folder

## 5. Which of the following is an example of a vector graphics device in R?
## - JPEG
## yes - Postscript
## - GIF
## - PNG
## - TIFF

## 6. Bitmapped file formats can be most useful for
## - Plots that require animation or interactivity
## no  - Plots that may need to be resized
## yes - Scatterplots with many many points
## - Plots that are not scaled to a specific resolution

## 7. Which of the following functions is typically used to add elements
## to a plot in the base graphics system?
## yes - text()
## - boxplot()
## - hist()
## - plot()
 
## 8. Which function opens the screen graphics device on Windows?
## yes - windows()
## - jpeg()
## - postscript()
## - xfig()

## 9. What does the 'pch' option to par() control?
## - the line width in the base graphics system
## - the orientation of the axis labels on the plot
## - the size of the plotting symbol in a scatterplot
## yes - the plotting symbol/character in the base graphics system
## 
## 10. If I want to save a plot to a PDF file, which of the following 
## is a correct way of doing that?
## yes - Construct the plot on the screen device and then copy it to a PDF file
##   with dev.copy2pdf()
## - Construct the plot on the PNG device with png(), 
##   then copy it to a PDF with dev.copy2pdf().
## - Open the PostScript device with postscript(), construct the plot, 
##   then close the device with dev.off().
## - Open the screen device with quartz(), construct the plot, 
##   and then close the device with dev.off().