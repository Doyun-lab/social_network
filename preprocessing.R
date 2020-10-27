setwd("/Users/doyun/Downloads")
library(tidyverse)

df <- read.csv("sna_data.csv", fileEncoding = "euc-kr", stringsAsFactors = F)

a <- subset(df, select=c('지.역','X','X.1','X.2'))
a <- unite(a, col="지역",지.역,X,X.1,X.2,sep="")
result <- data.frame(a, df[,5:268])
result <- result[2:221, ] 

df <- t(result)

b <- df[1, ]

q <- seq(2, 264 , by = 2)
t <- data.frame()
for (a in q){
  t <- rbind(t, df[q,])
}

colnames(t) <- b

sna <- t[1:132,]

names(sna)[which(names(sna) == "중구")] <- c("서울중구", "인천중구", "부산중구", "대구중구", "대전중구", "울산중구")
names(sna)[which(names(sna) == "남구")] <- c("인천남구" , "부산남구", "대구남구", "광주남구", "울산남구", "포항남구")
names(sna)[which(names(sna) == "동구")] <- c("인천동구", "부산동구", "대구동구", "광주동구", "대전동구","울산동구")
names(sna)[which(names(sna) == "강서구")] <- c("서울강서구","부산강서구")
names(sna)[which(names(sna) == "북구")] <- c("부산북구", "대구북구","광주북구" ,"울산북구" ,"포항북구")
names(sna)[which(names(sna) == "서구")] <- c("인천서구", "부산서구", "대구서구" ,"광주서구" ,"대전서구")

sna$경부2권 <- NULL
sna$용인시 <- NULL
sna$수원시 <- NULL
sna$서해안권 <- NULL
sna$안산시 <- NULL
sna$동부1권 <- NULL
sna$동부2권 <- NULL
sna$경의권 <- NULL
sna$고양시 <- NULL
sna$강북지역 <-NULL
sna$도심권 <- NULL
sna$동북권 <- NULL
sna$서북권 <- NULL
sna$서남권 <- NULL
sna$동남권 <- NULL
sna$경기 <- NULL
sna$경부1권 <- NULL
sna$안양시 <- NULL
sna$성남시 <- NULL
sna$제주 <- NULL
sna$경원권 <- NULL
sna$인천 <- NULL 
sna$부산 <- NULL 
sna$중부산권 <- NULL 
sna$동부산권 <- NULL 
sna$서부산권 <- NULL
sna$대구 <- NULL
sna$광주 <- NULL
sna$대전 <- NULL
sna$울산 <- NULL
sna$경북 <- NULL
sna$경남 <- NULL
sna$충북 <- NULL
sna$충남 <- NULL
sna$전북 <- NULL
sna$전남 <- NULL
sna$강원 <- NULL
sna$창원시 <- NULL
sna$포항시 <- NULL
sna$천안시 <- NULL
sna$전주시 <- NULL
sna$청주시 <- NULL

data <- data.frame(sna)

# 인천남구 -> 미추홀구로 구명 변경으로 바꿔줌
data <- as.data.frame(apply(data, 2, as.numeric))
nrow(data)
132/4
# 1~76, 77~132
net <- t(data.frame(apply(data[1:33, ], 2, mean, na.rm = T), apply(data[34:66, ], 2, mean, na.rm = T),
                    apply(data[67:101, ], 2, mean, na.rm = T), apply(data[102:132, ], 2, mean, na.rm = T)))
net <- data.frame(net)

comb <- combn(colnames(net), 2) %>% t()

rownames(net) <- c("one", "two", "three", "four")
net$강원.1 <- NULL

change <- data.frame(apply(net, 2, diff))

change <- t(change)
change <- data.frame(change)
colnames(change) <- c("a", "b", "c")

a <- data.frame(change$a)
b <- data.frame(change$b)
c <- data.frame(change$c)

colnames(a) <- "지수"
colnames(b) <- "지수"
colnames(c) <- "지수"

d <- data.frame(rbind(a, b, c))

nm <- data.frame(rownames(change))
ae <- data.frame(rbind(nm, nm, nm))

last <- data.frame(cbind(d, ae))
colnames(last) <- c("지수", "지역")

price <- c()
for(i in 1:nrow(comb)){ # 조합 한줄씩 읽어오기
  # i번째 조합의 첫번째 주식의 종가diff 추출
  a <- last[last$지역 == comb[i, 1], "지수"]
  b <- last[last$지역 == comb[i, 2], "지수"]
  print(i)
  
  price <- c(price, cor(a, b)) # 두 주식 correlation 산출 후 저장
}
price

seoul <- c("종로구", "서울중구", "성동구", "광진구", "동대문구", "중랑구", "성북구",
           "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "강남지역",
           "양천구", "서울강서구", "구로구", "금천구", "영등포구", "동작구",
           "관악구", "서초구", "강남구", "송파구", "강동구", "용산구")

gig <- c('과천시','만안구','동안구','수정구','중원구','분당구',
         '군포시','의왕시','안성시','처인구','기흥구','수지구',
         '장안구','권선구','팔달구','영통구','부천시','상록구',
         '단원구','시흥시','광명시','화성시','오산시','평택시',
         '남양주시','구리시','하남시','광주시','이천시','여주시','김포시',
         '덕양구','일산동구','일산서구','파주시','포천시','동두천시','양주시', "의정부시")

ic <- c("인천중구","인천동구","인천남구","연수구","남동구","부평구","계양구","인천서구", "미추홀구")

busan <- c("부산중구","부산서구","부산동구","영도구","부산진구","부산남구",
           "연제구","수영구","해운대구","금정구","동래구","기장군","부산북구", "부산강서구", 
           "사상구","사하구", "울산중구", "울산남구", "울산동구", "울산북구" ,"울주군")

daegu <- c("대구중구","대구동구","대구서구","대구남구","대구북구","수성구","달서구","달성군")

kwangju <- c("광주동구", "광주서구", "광주남구", "광주북구", "광산구")  

daejun <- c("대전동구", "대전중구", "대전서구", "유성구", "대덕구")  

gangwon <-c('춘천시','원주시','강릉시','동해시','태백시','속초시')

chunbuk <-c('삼척시','상당구','서원구','흥덕구','청원구','충주시','제천시','음성군')

chungnam <- c("동남구" ,"서북구", "공주시", "보령시", "서산시", "아산시", "논산시", "계룡시", "홍성군", "예산군", "당진시")

junbuk <- c("완산구", "덕진구", "군산시", "익산시", "정읍시" ,"남원시", "김제시")

junnam <- c("목포시", "여수시", "순천시", "나주시", "광양시", "무안군")

kb <- c("포항남구", "포항북구","경주시","김천시","안동시","구미시","영주시","영천시","상주시","문경시","경산시","칠곡군")
kn <- c("의창구","성산구","마산합포구","마산회원구","진해구","진주시","통영시","사천시","밀양시","김해시","거제시","양산시")
jeju <- c("제주시","서귀포시")
