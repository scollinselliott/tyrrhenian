library(coda)
library(ggplot2)
library(reshape2)
library(fitdistrplus)
library(MCMCpack)
library(fitdistrplus)
library(devtools)
library(cowplot)

setwd("C:/Users/tennessee2/Documents/2018 AIAC Cologne-Bonn/scripts")


cer1ce = read.csv("result-cer50.csv")
cer1bce = read.csv("result-cer-50.csv")
cer2bce = read.csv("result-cer-150.csv")
cer3bce = read.csv("result-cer-250.csv")
cer4bce = read.csv("result-cer-350.csv")

cru1ce = read.csv("result-cru50.csv")
cru1bce = read.csv("result-cru-50.csv")
cru2bce = read.csv("result-cru-150.csv")
cru3bce = read.csv("result-cru-250.csv")
cru4bce = read.csv("result-cru-350.csv")

sab1ce = read.csv("result-sab50.csv")
sab1bce = read.csv("result-sab-50.csv")
sab2bce = read.csv("result-sab-150.csv")
sab3bce = read.csv("result-sab-250.csv")
sab4bce = read.csv("result-sab-350.csv")

fid1ce = read.csv("result-fid50.csv")
fid1bce = read.csv("result-fid-50.csv")
fid2bce = read.csv("result-fid-150.csv")
fid3bce = read.csv("result-fid-250.csv")
fid4bce = read.csv("result-fid-350.csv")



cru1ce <- as.data.frame.matrix(cru1ce)
cru1bce <- as.data.frame.matrix(cru1bce)
cru2bce <- as.data.frame.matrix(cru2bce )
cru3bce <- as.data.frame.matrix(cru3bce )
cru4bce <- as.data.frame.matrix(cru4bce )
cer1ce <- as.data.frame.matrix(cer1ce )
cer1bce <- as.data.frame.matrix(cer1bce )
cer2bce <- as.data.frame.matrix(cer2bce )
cer3bce <- as.data.frame.matrix(cer3bce )
cer4bce <- as.data.frame.matrix(cer4bce )
sab1ce	<-	as.data.frame.matrix(	sab1ce	)
sab1bce	<-	as.data.frame.matrix(	sab1bce	)
sab2bce	<-	as.data.frame.matrix(	sab2bce	)
sab3bce	<-	as.data.frame.matrix(	sab3bce	)
sab4bce	<-	as.data.frame.matrix(	sab4bce	)
fid1ce	<-	as.data.frame.matrix(	fid1ce	)
fid1bce	<-	as.data.frame.matrix(	fid1bce	)
fid2bce	<-	as.data.frame.matrix(	fid2bce	)
fid3bce	<-	as.data.frame.matrix(	fid3bce	)
fid4bce	<-	as.data.frame.matrix(	fid4bce	)
sab1ce$X	<-	NULL
sab1bce$X	<-	NULL
sab2bce$X	<-	NULL
sab3bce$X	<-	NULL
sab4bce$X	<-	NULL
fid1ce$X	<-	NULL
fid1bce$X	<-	NULL
fid2bce$X	<-	NULL
fid3bce$X	<-	NULL
fid4bce$X	<-	NULL


cru1ce$X	<-	NULL
cru1bce$X	<-	NULL
cru2bce$X	<-	NULL
cru3bce$X	<-	NULL
cru4bce$X	<-	NULL
cer1ce$X	<-	NULL
cer1bce$X	<-	NULL
cer2bce$X	<-	NULL
cer3bce$X	<-	NULL
cer4bce$X	<-	NULL

cru1ce$century	<-	"	1 c CE	"
cru1bce$century	<-	"	1 c BCE	"
cru2bce$century	<-	"	2 c BCE	"
cru3bce$century	<-	"	3 c BCE	"
cru4bce$century	<-	"	4 c BCE	"
cer1ce$century	<-	"	1 c CE	"
cer1bce$century	<-	"	1 c BCE	"
cer2bce$century	<-	"	2 c BCE	"
cer3bce$century	<-	"	3 c BCE	"
cer4bce$century	<-	"	4 c BCE	"

sab1ce$century	<-	"	1 c CE	"
sab1bce$century	<-	"	1 c BCE	"
sab2bce$century	<-	"	2 c BCE	"
sab3bce$century	<-	"	3 c BCE	"
sab4bce$century	<-	"	4 c BCE	"
fid1ce$century	<-	"	1 c CE	"
fid1bce$century	<-	"	1 c BCE	"
fid2bce$century	<-	"	2 c BCE	"
fid3bce$century	<-	"	3 c BCE	"
fid4bce$century	<-	"	4 c BCE	"

cru1ce		<-	melt(	cru1ce	)
cru1bce		<-	melt(	cru1bce	)
cru2bce		<-	melt(	cru2bce	)
cru3bce		<-	melt(	cru3bce	)
cru4bce		<-	melt(	cru4bce	)
cer1ce		<-	melt(	cer1ce	)
cer1bce		<-	melt(	cer1bce	)
cer2bce		<-	melt(	cer2bce	)
cer3bce		<-	melt(	cer3bce	)
cer4bce		<-	melt(	cer4bce	)
sab1ce	<-	melt(	sab1ce	)
sab1bce	<-	melt(	sab1bce	)
sab2bce	<-	melt(	sab2bce	)
sab3bce	<-	melt(	sab3bce	)
sab4bce	<-	melt(	sab4bce	)
fid1ce	<-	melt(	fid1ce	)
fid1bce	<-	melt(	fid1bce	)
fid2bce	<-	melt(	fid2bce	)
fid3bce	<-	melt(	fid3bce	)
fid4bce	<-	melt(	fid4bce	)

cru1ce		<-				cru1ce[!apply(cru1ce	== 0, 1, FUN = any, na.rm = TRUE),]			
cru1bce		<-				cru1bce[!apply(cru1bce	== 0, 1, FUN = any, na.rm = TRUE),]			
cru2bce		<-				cru2bce[!apply(cru2bce	== 0, 1, FUN = any, na.rm = TRUE),]			
cru3bce		<-				cru3bce[!apply(cru3bce	== 0, 1, FUN = any, na.rm = TRUE),]			
cru4bce		<-				cru4bce[!apply(cru4bce	== 0, 1, FUN = any, na.rm = TRUE),]			
cer1ce		<-				cer1ce[!apply(cer1ce	== 0, 1, FUN = any, na.rm = TRUE),]			
cer1bce		<-				cer1bce[!apply(cer1bce	== 0, 1, FUN = any, na.rm = TRUE),]			
cer2bce		<-				cer2bce[!apply(cer2bce	== 0, 1, FUN = any, na.rm = TRUE),]			
cer3bce		<-				cer3bce[!apply(cer3bce	== 0, 1, FUN = any, na.rm = TRUE),]			
cer4bce		<-				cer4bce[!apply(cer4bce	== 0, 1, FUN = any, na.rm = TRUE),]			
sab1ce	<-	sab1ce	[!apply(	sab1ce		== 0, 1, FUN = any, na.rm = TRUE),]			
sab1bce	<-	sab1bce	[!apply(	sab1bce		== 0, 1, FUN = any, na.rm = TRUE),]			
sab2bce	<-	sab2bce	[!apply(	sab2bce		== 0, 1, FUN = any, na.rm = TRUE),]			
sab3bce	<-	sab3bce	[!apply(	sab3bce		== 0, 1, FUN = any, na.rm = TRUE),]			
sab4bce	<-	sab4bce	[!apply(	sab4bce		== 0, 1, FUN = any, na.rm = TRUE),]			
fid1ce	<-	fid1ce	[!apply(	fid1ce		== 0, 1, FUN = any, na.rm = TRUE),]			
fid1bce	<-	fid1bce	[!apply(	fid1bce		== 0, 1, FUN = any, na.rm = TRUE),]			
fid2bce	<-	fid2bce	[!apply(	fid2bce		== 0, 1, FUN = any, na.rm = TRUE),]			
fid3bce	<-	fid3bce	[!apply(	fid3bce		== 0, 1, FUN = any, na.rm = TRUE),]			
fid4bce	<-	fid4bce	[!apply(	fid4bce		== 0, 1, FUN = any, na.rm = TRUE),]			

cru <- rbind(cru1ce,	cru1bce,	cru2bce,	cru3bce,	cru4bce)
cer <- rbind(	cer1ce,	cer1bce,	cer2bce,	cer3bce,	cer4bce)
fid <- rbind(fid1ce,fid1bce,fid2bce,fid3bce,fid4bce)
sab <- rbind(	sab1ce,	sab1bce,	sab2bce,	sab3bce,	sab4bce)



select_category <- function(.region, .category) {.region[ which(.region$variable=='.category'), ]}


custom_plot <- function(.data, .title) {
  ggplot(.data, aes(century,value, color = variable )) +
geom_jitter(size=1, alpha = I(1 / 10)) +
theme_classic() + theme(axis.text.x = element_text(angle = 270, hjust = 0)) + theme(legend.position="none")  + 
scale_x_discrete(limits=c("4 c BCE","3 c BCE","2 c BCE","1 c BCE","1 c CE")) +
      labs(x="", y="") + ggtitle(.title)
}




anfcer <- cer[ which(cer$variable=='anfora'), ]
anfcru <- cru[ which(cru$variable=='anfora'), ]
anffid <- fid[ which(fid$variable=='anfora'), ]
anfsab <- sab[ which(sab$variable=='anfora'), ]


varlab <- 'marmo'


anfcer <- cer[ which(cer$variable==varlab), ]
anfcru <- cru[ which(cru$variable==varlab), ]
anffid <- fid[ which(fid$variable==varlab), ]
anfsab <- sab[ which(sab$variable==varlab), ]



p.anfcer <- custom_plot(anfcer, "Caere")
p.anfcru <- custom_plot(anfcru , "Crustumerium")
p.anffid <- custom_plot(anffid , "Fidenae")
p.anfsab <- custom_plot(anfsab , "Cures Sabini")


plot_grid(p.anfcer , p.anfcru , p.anffid , p.anfsab, ncol=4)
