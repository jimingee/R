rm(list=ls())

height <- c(163,161,168,161,157,162,153,159,164,170,
            152,160,157,168,150,165,156,151,162,150,
            156,152,161,165,168,167,165,168,159,156)
height

# 점추정
n <- length(height);n
xbar <- mean(height);xbar  # 표본평균
s <- sd(height);s # 표준편차
se <- s/sqrt(n);se # 표준오차

# 구간추정
# qnorm : normal 분포의 quantile -> z_alpha값 알수 있음
qnorm(0.025) # qnorm(p): P(Z<x)=p 
qnorm(1-0.025)
qnorm(0.025,lower.tail=F) # : P(Z>x)=p

# 95% 신뢰구간
alpha <- 0.05
z_0.025 <- qnorm(1-alpha/2);z_0.025  # 
c(xbar-z_0.025*se,xbar+z_0.025*se) # 95% Confidence Interval

# 99% 신뢰구간
alpha <- 0.01
z_0.005 <- qnorm(1-alpha/2);z_0.005 
c(xbar-z_0.005*se,xbar+z_0.005*se) # 99% Confidence Interval

## 해석: 99%의 신뢰도일 경우에 신뢰구간이 더 길다


# 신뢰구간의 의미
for (i in c(1,3,2,4,5)) {
  print(i)
}

rnorm(80,0,1) # 정규분포에서 80개의 표본 random 추출
rnorm(80) # rnorm(80,0,1)랑 똑같음
set.seed(1) # 난수값 고정
rnorm(80)
set.seed(1)
rnorm(80)

seq(100) # 1:100 랑 똑같음


xbar <- c();xbar
sd <- c();sd

for (i in 1:100) { # -> 표본(크기:80)을 100번 추출
  set.seed(i)
  temp <- rnorm(80) # 각seed 별로 난수를 80개 추출 
  xbar[i] <- mean(temp)
  sd[i] <- sd(temp)
}

xbar
sd

n <- 80;n
se <- sd/sqrt(n);se 
z_0.025 <- qnorm(0.025,lower.tail=F);z_0.025  # 신뢰도 95%
lower <- xbar-z_0.025*se;lower
upper <- xbar+z_0.025*se;upper

plot(xbar,cex=0.7,ylim=c(-1,1)) # 표본의 평균
abline(h=0,col='red')

for (i in 1:100) { # 신뢰구간
  segments(i,lower[i],i,upper[i])
}

100-sum(lower>0|upper<0) # 신뢰도 95%일 경우, 평균을 포함하는 추정구간의 개수

## 모평균에 대한 가설 검정
# 예제. 특정 체중감량 보조제를 복용하였을 때, 
# 5주 동안 10kg이상을 감량할 수 있다는 해당 업체의 주장이 옳다고 할 수 있는지 유의수준 5%로 검정하라.
# 참가자는 56명이며 5주동안 체중 감소량의 평균은 10.5, 표준편차는 4.5였다.
# H0: mu = 10 vs. H1: mu > 10
n <- 56;n
xbar <- 10.5;xbar  # 표본 평균
sd <- 4.5;sd   # 표본 표준편차
se <- sd/sqrt(n);se # 표준 오차
mu_0 <- 10;mu_0

z_0.05 <- qnorm(0.05,lower.tail=F);z_0.05  # 단측 검정
Z <- (xbar-mu_0)/se;Z  # z 통계량
Z > z_0.05 # 기각X -> H0 채택
p_value <- pnorm(Z,lower.tail=F);p_value
# 체중감량 보조제를 복용하여 10kg 이상을 감량할 수 있다고 할 수 없다.
p_value <- pnorm(Z);p_value
?pnorm

# 예제. 추정 예제에서 중학교 남학생 키의 평균이 다른 도시 중학교 1학년 남학생 평균 키 159와 차이가 있는지 검정하라.
# 앞서 구한 키의 평균은 160.2, 표준편차는 5.99였으며 학생 수는 30명이었다.
# H0: mu = 159 vs. H1: mu != 159
n <- 30;n
xbar <- 160.2;xbar
sd <- 5.99;sd
se <- sd/sqrt(n);se
mu_0 <- 159;mu_0

Z <- (xbar-mu_0)/se;Z 
p_value <- 2*pnorm(abs(Z), lower.tail=F);p_value
# 유의수준이 알려져 있지 않지만, 주로 사용하는 0.05,0.01,0.1보다 p-값이 크므로 H0�각하는 것이 바람직하지 않다. 주어
# 진 도시의 중학교 1학년 남학생 평균키가 다른 도시의 평균과 차이가 있다고 판단할 수 없다.