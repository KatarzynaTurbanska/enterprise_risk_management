library(rugarch)

data <- read.csv('kakao_straty.csv')
data <- data$lost

mod_specify = ugarchspec(mean.model = list(armaOrder=c(0,0)), 
                          variance.model = list(model='sGARCH',garchOrder=c(1,1)),
                          distribution.model = 'norm')

mod_fittng = ugarchfit(data = data, spec = mod_specify)

sigmas <- sigma(mod_fittng)
length(sigmas)
length(data)
coef <- coef(mod_fittng)

sigma2 <- sqrt(coef['omega'] + coef['alpha1']*data[2]^2  + coef['beta1']*3.00411^2)

sigmas <- data.frame(sigmas)
sigmas <- sigmas$sigmas
plot(sigmas)
plot(data,type='l')

filtr_data <- (data - coef['mu'])/sigmas
q95 <- quantile(filtr_data,0.95)

future_sigma <- sqrt(coef['omega'] + coef['alpha1']*data[length(data)]^2  + coef['beta1']*sigmas[length(sigmas)]^2)
VaR <- future_sigma * q95 + coef['mu']
VaR
