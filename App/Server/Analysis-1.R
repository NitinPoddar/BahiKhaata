library(waterfalls)
Analysis1<-read.csv("App/Analysis-1.csv")
waterfallchart(value~label, data=Analysis1, groups=Analysis1$subtotal)
Analysis1$subtotal<-"Valuation"
Analysis1<-Analysis1[c(1:12,14),1:2]
waterfallplot(height, width = 1, space = NULL, names.arg = NULL,
              horiz = FALSE, density = NULL, angle = 45, col = NULL,
              border = par("fg"), main = NA, sub = NA, xlab = NULL, ylab = NULL,
              xlim = NULL, ylim = NULL, xpd = TRUE, axes = TRUE, axisnames = TRUE,
              cex.axis = par("cex.axis"), cex.names = par("cex.axis"), plot = TRUE,
              axis.lty = 0, offset = 0, add = FALSE, summary = FALSE, rev = FALSE,
              level.lines = TRUE, ...)
waterfallplot(Analysis1$value, names.arg=Analysis1[,2],horiz=F,space=0.1,summary=F,add=T ,density=c(1:12),col="blue",xpd=N)
waterfallchart(x, data = NULL, groups = NULL, horizontal = FALSE,
               panel = panel.waterfallchart, prepanel = prepanel.waterfallchart,
               summaryname = "Total", box.ratio = 4, origin = 0, level.lines = TRUE)
waterfall(values =Analysis1$value , labels =Analysis1$label, calc_total = TRUE,fill_by_sign = T) +theme_bw()
fill_colours = colorRampPalette(c("#1b7cd7", "#d5e6f2"))(7), 
waterfall(.data = data.frame(category = letters[1:5], value = c(100, -20, 10, 20, 110)), fill_by_sign = FALSE)+theme_bw()