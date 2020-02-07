
void OnTick()
  {
      MqlRates prices[];
      ArraySetAsSeries(prices,true);
      CopyRates(_Symbol,_Period,0,3,prices);
      
      static int countCandles;
      static datetime lastCheckTime;
      
      datetime currentTime;
      currentTime=prices[0].time;
      if(currentTime!=lastCheckTime)
      {
         lastCheckTime=currentTime;
         countCandles+=1;
      }
      
      Comment("\nCandle Count: ",countCandles);
      
   
  }

