# https://www.r-bloggers.com/computing-and-visualizing-pca-in-r/

# Following my introduction to PCA, I will demonstrate how to apply and visualize PCA in R. There are many packages and functions that can apply PCA in R. In this post I will use the function prcomp from the stats package. I will also show how to visualize PCA in R using Base R graphics. However, my favorite visualization function for PCA is ggbiplot, which is implemented by Vince Q. Vu and available on github. Please, let me know if you have better ways to visualize PCA in R.

# Computing the Principal Components (PC)

I will use the classical iris dataset for the demonstration. The data contain four continuous variables which corresponds to physical measures of flowers and a categorical variable describing the flowers’ species.




# Load data
data(iris)

print(head(iris, 3))

log.ir <- log(iris[, 1:4])


plot(log.ir)

ir.species <- iris[, 5]
 
# apply PCA - scale. = TRUE is highly 
# advisable, but default is FALSE. 
ir.pca <- prcomp(log.ir,
                 center = TRUE,
                 scale. = TRUE) 


# Analyzing the results

# print method
print(ir.pca)

# The plot method returns a plot of the variances (y-axis) associated with the PCs (x-axis). The Figure below is useful to decide how many PCs to retain for further analysis. In this simple case with only 4 PCs this is not a hard task and we can see that the first two PCs explain most of the variability in the data.

# plot method
plot(ir.pca, type = "l")

# The summary method describe the importance of the PCs. The first row describe again the standard deviation associated with each PC. The second row shows the proportion of the variance in the data explained by each component while the third row describe the cumulative proportion of explained variance. We can see there that the first two PCs accounts for more than  of the variance of the data.

# summary method

print(summary(ir.pca))

# We can use the predict function if we observe new data and want to predict their PCs values. Just for illustration pretend the last two rows of the iris data has just arrived and we want to see what is their PCs values:

# Predict PCs
print(predict(ir.pca, 
        newdata=tail(log.ir, 2)))

# The Figure below is a biplot generated by the function ggbiplot of the ggbiplot package available on github.

# The code to generate this Figure is given by

library(devtools)
install_github("ggbiplot", "vqv")
 
library(ggbiplot)
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, 
              groups = ir.species, ellipse = TRUE, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
print(g)

# It projects the data on the first two PCs. Other PCs can be chosen through the argument choices of the function. It colors each point according to the flowers’ species and draws a Normal contour line with ellipse.probprobability (default to ) for each group. More info about ggbiplot can be obtained by the usual ?ggbiplot. I think you will agree that the plot produced by ggbiplot is much better than the one produced by biplot(ir.pca)(Figure below).

# I also like to plot each variables coefficients inside a unit circle to get insight on a possible interpretation for PCs. Figure 4 was generated by this code available on gist.









