
void OnTick()
  {
      int CountPositionForThisCurrencyPair=0;
      for(int i=PositionsTotal()-1;i>=0;i--)
      {
         string symbol=PositionGetSymbol(i);
         Pos
            
         if(Symbol()==symbol)
         {
            CountPositionForThisCurrencyPair+=1;
         }
      }
      
      Comment("\n\nPositions for this currency pair",CountPositionForThisCurrencyPair);
   
  }

